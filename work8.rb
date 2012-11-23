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
			@acc = ["adnan99","adnan101","adnan102","adnan103","adnan104","adnan105","adnan106","adnan107","adnan108","adnan109", "adnan110","bakeri1","bakeri2", "bakeri3","halim1", "zaid1","zaid2","amran1", "amran2", "amran3"]



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




