require "#{File.dirname(__FILE__)}/robot_lib"
include ROBOT




accounts = Array.new
@acc = []
#@acc = ["AD666", "adnan1", "adnan8", "adnan9", "adnan10", "adnan14", "adnan15", 
#	   "adnan16", "adnan17", "adnan18", "adnan19", "adnan20", "adnan21"]
@acc = ["adnan27","adnan28","adnan29","adnan30","adnan31","adnan32","adnan33","adnan34", "adnan35", "adnan36", "adnan37"] 

#accounts[0] = ["AD666", "adnan1", "adnan8"]
#accounts[1] = ["adnan9", "adnan10", "adnan14"]
#accounts[2] = ["adnan15", "adnan16", "adnan17"]
#accounts[3] = ["adnan18", "adnan19", "adnan20", "adnan21"]



File.open("#{File.dirname(__FILE__)}/email.txt", 'w') { |file| file.puts(" ") }
File.open("#{File.dirname(__FILE__)}/email.txt", 'a') { |file| file.puts(" ") }
File.open("#{File.dirname(__FILE__)}/email.txt", 'a') { |file| file.puts("Click report for #{ Time.now.strftime("%Y-%m-%d") }") }
File.open("#{File.dirname(__FILE__)}/email.txt", 'a') { |file| file.puts("===================================================") }
File.open("#{File.dirname(__FILE__)}/email.txt", 'a') { |file| file.puts(" ") }
until @acc.empty?
	puts @acc.join(" ")
	@acc.each do |u|
		#u.each do |username|
		puts u
		begin
			@db = Click.where(:click_date => Time.now.strftime("%Y-%m-%d"), :account => u).first
			@db = Click.create(:click_date => Time.now.strftime("%Y-%m-%d"), :account => u) if @db.nil?
			puts "#{u} #{@db.total_clicks}"
			if @db.total_clicks < 5
				u = Utils.new(u, "660066", 5)
				u.process
				#@t = Thread.new{ u.process }
			else
				@acc.delete(u)
				File.open("#{File.dirname(__FILE__)}/email.txt", 'a') { |file| file.puts("#{u}\t\t#{@db.total_clicks} clicks\t\tRM#{@db.total_clicks}") }
			end
		rescue Exception => e  
			puts e.message
			#retry
		end
		#end
	end
	puts @acc.join(" ")
	#@t.join
end

#send email
MyMailer.send_mail("amir@localhost.my, amirharis@gmail.com, zapawie@gmail.com", "3Plea report for 5 clicks").deliver




