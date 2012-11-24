require "#{File.dirname(__FILE__)}/robot_lib"
include ROBOT


loop do

	@email = Email.where( :email_date => Time.now.strftime("%Y-%m-%d"), :typ => 1).first
	@email = Email.create( :email_date => Time.now.strftime("%Y-%m-%d") ) if @email.nil?

	unless @email.sent
		if Utils.email_clicks
			puts "inside"
			File.open("#{File.dirname(__FILE__)}/email.txt", 'w') { |file| file.puts(" ") }
			File.open("#{File.dirname(__FILE__)}/email.txt", 'a') { |file| file.puts(" ") }
			File.open("#{File.dirname(__FILE__)}/email.txt", 'a') { |file| file.puts("Click report for #{ Time.now.strftime("%Y-%m-%d") }") }
			File.open("#{File.dirname(__FILE__)}/email.txt", 'a') { |file| file.puts("===================================================") }
			File.open("#{File.dirname(__FILE__)}/email.txt", 'a') { |file| file.puts(" ") }

			clicks = Click.where(:click_date => Time.now.strftime("%Y-%m-%d") ).order("total_clicks")


			@total = 0
			clicks.each_with_index do |c, i|
				File.open("#{File.dirname(__FILE__)}/email.txt", 'a') { |file| file.puts("#{i+1}. #{c.account}\t\t#{c.total_clicks} clicks\t\tRM#{c.total_clicks}\t\t#{c.updated_at}") }
				@total = @total + c.total_clicks
			end

			File.open("#{File.dirname(__FILE__)}/email.txt", 'a') { |file| file.puts("Total: RM #{@total}") }

			MyMailer.send_mail("amir@localhost.my, amirharis@gmail.com, zapawie@gmail.com", "3Plea report for #{ Time.now.strftime("%Y-%m-%d") }").deliver
			@email.update_attributes(:sent => true)
		end
	end

	sleep 300
end