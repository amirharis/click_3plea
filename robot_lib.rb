require "selenium-webdriver" 
require 'action_mailer'
require 'active_record'
require 'mail'

module ROBOT
	ActiveRecord::Base.establish_connection(  
  		:adapter => "mysql2",  
  		:host => "localhost",  
  		:database => "3plea",
  		:username => "root",
  		:password => ""
	)  
  
	class Click < ActiveRecord::Base  
	end

	class State < ActiveRecord::Base  
	end

	class MyMailer < ActionMailer::Base
			
		default :from => "poc@dnscell.com"

  		def load_settings
		  	ActionMailer::Base.smtp_settings = {
		      :address        => "smtp.gmail.com",
		      :port           => 587,
		      :domain         => "dnscell.com",
		      :authentication => "plain",
		      :user_name      => "poc@dnscell.com",
		      :password       => "localhost2012",
		      :enable_starttls_auto => true
		    }
		    ActionMailer::Base.delivery_method = :smtp
		    ActionMailer::Base.perform_deliveries = true
		    ActionMailer::Base.raise_delivery_errors = true
  		end

  		def send_mail rec, subj, bod=nil
    		load_settings  
    		mail(	:to => rec, :subject => subj, 
    				:content_type  => "text/plain",
    				:body => File.read("#{File.dirname(__FILE__)}/email.txt")
    			)
  		end
	end

	class Utils
		def initialize(username, password, clicks)
	        @username = username
	        @password = password
	        @clicks = clicks
	        @page = 1
	        @driver = Selenium::WebDriver.for :chrome
	    end

		def current_date
			time = Time.now
			time.strftime("%Y%m%d")
		end

		def today_bonus()
			@driver.navigate.to("http://www.3plea.com/member/mCABReportD.asp?DX=#{current_date}")
			counts = @driver.find_elements(:tag_name, "a")

			wa = 0

			adv_ids = []
			counts.each do |count|
				if count.attribute("href") =~ /adv.asp/
			      wa = wa+1
			      puts count.attribute("href")
			      adv_ids << count.attribute("href").split("?")[1].split("=")[1]
			  	end
	  		end

	  		return wa, adv_ids
		end 

		def inc x = 1
    		@page += x
  		end

  		def reset
    		@page = 1
  		end


		def find_links(x=1, *adv_ids)

			if @page == 1
				self.inc
				@driver.navigate.to "http://www.3plea.com/member/cads.asp"
			else
				#@navigate = false
				@driver.navigate.to "http://www.3plea.com/member/cads.asp"
				next_page = @driver.find_elements(:tag_name, "a")
				next_page.each do |link| 
			  	#puts link.attribute("href") 
			  	    puts link.attribute("href") 
			  	    puts @page
				  	#if link.attribute("href") =~ /cads.asp?page=#{@page.succ}&cx=0/
				  	if link.attribute("href") == "http://www.3plea.com/member/cads.asp?page=#{@page}&cx=0"
				  		puts "inside troll"
				  		self.inc
				  		@driver.navigate.to "http://www.3plea.com/member/cads.asp?page=#{@page-1}&cx=0"
				  		#@navigate = false		
				  		break
				  	else
				  		self.reset
				  		self.inc
				  		#@navigate = true
				  	end
				end
				#If something went wrong
				#if @navigate 
				#	@driver.navigate.to "http://www.3plea.com/member/cads.asp"
				#end
			end

			#if x == 1
			#	@driver.navigate.to "http://www.3plea.com/member/cads.asp"
			#else
			#	@driver.navigate.to "http://www.3plea.com/member/cads.asp?page=#{x}&cx=0"
			#end

			links = @driver.find_elements(:tag_name, "a")
			adv_links = []
			links.each do |link| 
	  		#puts link.attribute("href") 
		  		if link.attribute("href") =~ /adv.asp/
		  			unless adv_ids.include?link.attribute("href").split("?")[1].split("=")[1]
			    		adv_links << link.attribute("href")
			    		puts link.attribute("href")
					else
						puts "Already exist: #{link.attribute('href')} "
					end
		  		end
			end
			return *adv_links
		end

		def abort
			@driver.quit
		end

		def get_chrome_id
			bridge = @driver.instance_variable_get(:@bridge)
			launcher = bridge.instance_variable_get(:@launcher)
			binary = launcher.instance_variable_get(:@binary)
			process = binary.instance_variable_get(:@process)
			process.pid
		end

		def process
			#login using chrome
			begin
				#Database
				@db = Click.where(:click_date => Time.now.strftime("%Y-%m-%d"), :account => @username).first

				#puts self.get_chrome_id
				@driver.navigate.to "http://www.3plea.com/memberLogin.asp"
				element = @driver.find_elements(:tag_name, "input")[0]
				element.send_keys @username
				element = @driver.find_elements(:tag_name, "input")[1]
				element.send_keys @password
				key = @driver.find_elements(:tag_name, "font")[6].text
				element = @driver.find_elements(:tag_name, "input")[2]
				element.send_keys "#{key.split(".").join("")}"
				@driver.find_elements(:tag_name, "input")[3].click

				

				abort if @driver.current_url == "http://www.3plea.com/noService.asp"
				
				#abort if @driver.current_url == "http://www.3plea.com/member/home.asp"
				
				page = 0
				
				wa, adv_ids = today_bonus()

				if wa == 10
					@db.update_attributes(:total_clicks => wa)
					@driver.quit
				else
					@db.update_attributes(:total_clicks => wa)
					puts "Total clicks: #{wa}"

					x = 1

					wb = wa

					while wb < @clicks
						
						puts "Page: #{@page}"
						adv_links = find_links(1, *adv_ids)
						adv_links.each do |adv_link|

						  if wa == @clicks then
							next 
						  else
						  	@driver.navigate.to("#{adv_link}")	
						  end
						  
						  begin 
						  	#e = @driver.find_elements(:tag_name, "a")[19].attribute("href") if @driver.find_elements(:tag_name, "a")[19]
						  	all_links = @driver.find_elements(:tag_name, "a")
						  	all_links.each_with_index do |all_link, index|
							  	if all_link.attribute("href") =~ /clickadv.asp/
							  		#if wa < @clicks
							 		puts "#{x} #{ all_link.attribute("href") }"
							 		puts index
							 		@driver.find_elements(:tag_name, "a")[index].click
							 		#sleep 5
							  		unless @driver.find_elements(:tag_name, "font")[15].attribute("color") == "RED"
							  			x=x+1
							  			sleep 5+Random.rand(1)
							  			wa = wa + 1
							  		end
							  		#else
							  		#	puts "skipping"
							  		#end
							  	end
							end
						  rescue Exception => e  
						  	puts e.message
						  	break
						  end

						end

						puts "Robot.click: #{wa}"

						#sleep 10
						
						wb, adv_ids = today_bonus()
						wa = wb
						@db.update_attributes(:total_clicks => wb)

					end

					puts "Total clicks: #{wb}"
					@driver.quit
				end

				
			rescue Exception => e  
				
				@driver.quit
				puts e.message
				retry
			end
		end
	end
end
