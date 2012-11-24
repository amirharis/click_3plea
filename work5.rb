#!/usr/bin/env ruby
require "#{File.dirname(__FILE__)}/robot_lib"
include ROBOT



loop do

	@process = State.where(:click_date => Time.now.strftime("%Y-%m-%d"), :process => "5").first
	@process = State.create(:click_date => Time.now.strftime("%Y-%m-%d"), :process => "5") if @process.nil?

	
	unless @process.state
		if Time.now.strftime("%H").to_i >= 1

			accounts = Array.new
			#@acc = []
			@acc = ["adnan50", "adnan54", "adnan55", "adnan56", "adnan57", "adnan58", "adnan59", "adnan60", "adnan61", "adnan62", "adnan63", "adnan64", "adnan100"]

			#@acc = ["adnan16", "adnan17", "adnan18", "adnan19", "adnan20", "adnan21"]
			#@acc = ["adnan2","adnan3","adnan4","adnan5","adnan6","adnan7","adnan11","adnan12","adnan13","adnan22","adnan23",
			#"adnan24","adnan25","adnan26","adnan27","adnan28","adnan29","adnan30","adnan31","adnan32","adnan33", "adnan34", "adnan35", "adnan36", "adnan37", "adnan38", "adnan39", "adnan40", "adnan41", "adnan42","adnan43",
			#"adnan44", "adnan45", "adnan46", "adnan47", "adnan48", "adnan49"]

			#accounts[0] = ["AD666", "adnan1", "adnan8"]
			#accounts[1] = ["adnan9", "adnan10", "adnan14"]
			#accounts[2] = ["adnan15", "adnan16", "adnan17"]
			#accounts[3] = ["adnan18", "adnan19", "adnan20", "adnan21"]

			

			until @acc.empty?
				puts @acc.join(" ")
				@acc.each do |u|
					#u.each do |username|
					puts u
					begin
						@db = Click.where(:click_date => Time.now.strftime("%Y-%m-%d"), :account => u).first
						@db = Click.create(:click_date => Time.now.strftime("%Y-%m-%d"), :account => u) if @db.nil?
						puts "#{u} #{@db.total_clicks}"
						if @db.total_clicks < 10
							@u = Utils.new(u, "660066", 10)
							@u.process

							#@t = Thread.new{ u.process }
						else
							@acc.delete(u)
						end
					rescue Exception => e  
						puts e.message
						abort(e.message)
						puts @u.get_chrome_id
						@u.abort
						retry
					end
					#end
				end
				puts @acc.join(" ")
				#@t.join
			end

			#Done
			@process.update_attributes(:state => true)

		end#end time

	end#end unless

	sleep 30
end#end loop

#send email
#MyMailer.send_mail("amir@localhost.my, amirharis@gmail.com, zapawie@gmail.com", "3Plea report for 10 clicks").deliver




