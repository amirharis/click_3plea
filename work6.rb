require "#{File.dirname(__FILE__)}/robot_lib"
include ROBOT



loop do

	@process = State.where(:click_date => Time.now.strftime("%Y-%m-%d"), :process => "2").first
	@process = State.create(:click_date => Time.now.strftime("%Y-%m-%d"), :process => "2") if @process.nil?
	puts "asdas"

	unless @process.state
		if Time.now.strftime("%H").to_i >= 1

			accounts = Array.new
			@acc = []
			#@acc = ["AD666", "adnan1", "adnan8", "adnan9", "adnan10", "adnan14", "adnan15", 
			#	   "adnan16", "adnan17", "adnan18", "adnan19", "adnan20", "adnan21"]
			@acc = ["adnan51","adnan52","adnan53","adnan65","adnan66","adnan67","adnan68","adnan70","adnan71","adnan72", "adnan73","adnan74","adnan75", "adnan76","adnan77", "adnan78","adnan79","adnan80"]



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
						if @db.total_clicks < 5
							@u = Utils.new(u, "660066", 5)
							@u.process
							#@t = Thread.new{ u.process }
						else
							@acc.delete(u)
						end
					rescue Exception => e  
						puts e.message
						abort(e.message)
						@u.abort
						retry
					end
					#end
				end
				puts @acc.join(" ")
				#@t.join
			end

			@process.update_attributes(:state => true)
		
		end#end time

	end#end unless

	sleep 30
end#end loop

#send email
#MyMailer.send_mail("amir@localhost.my, amirharis@gmail.com, zapawie@gmail.com", "3Plea report for 5 clicks").deliver




