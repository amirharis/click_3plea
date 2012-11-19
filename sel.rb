#You need to require the gem "selenium-driver"
require "selenium-webdriver" 

#... see webdriver ruby api docs here: http://selenium.googlecode.com/svn/trunk/docs/api/rb/_index.html
#... Most usefull classes are Driver and Element, check them out for a good start
# Selenium::WebDriver::Chrome.path = "/usr/lib/chromium-browser/chromedriver"
driver = Selenium::WebDriver.for :chrome
driver.navigate.to "http://www.3plea.com/memberLogin.asp"
#element = driver.find_element(:name, 'q')
#element.send_keys "Hello WebDriver!"
#element = driver.find_element(:name,'Login ID')
element = driver.find_elements(:tag_name, "input")[0]
element.send_keys "adnan9"
#element = driver.find_element(:name,'Password')
element = driver.find_elements(:tag_name, "input")[1]
element.send_keys "660066"
key = driver.find_elements(:tag_name, "font")[6].text
element = driver.find_elements(:tag_name, "input")[2]
element.send_keys "#{key.split(".").join("")}"
driver.find_elements(:tag_name, "input")[3].click

def current_date
	time = Time.now
	time.strftime("%Y%m%d")
end

def today_bonus(driver)
	driver.navigate.to("http://www.3plea.com/member/mCABReportD.asp?DX=#{current_date}")
	counts = driver.find_elements(:tag_name, "a")

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

def find_links(driver, x=1, *adv_ids)
	if x == 1
		driver.navigate.to "http://www.3plea.com/member/cads.asp"
	else
		driver.navigate.to "http://www.3plea.com/member/cads.asp?page=#{x}&cx=0"
	end

	links = driver.find_elements(:tag_name, "a")
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

wa, adv_ids = today_bonus(driver)
puts "Total clicks: #{wa}"

x = 1

wb = wa

page = 1

while wb < 5
	adv_links = find_links(driver, page, *adv_ids)
	adv_links.each do |adv_link|
	  driver.navigate.to("#{adv_link}")
	  #element = driver.find_elements(:tag_name, "a")[20].click if driver.find_elements(:tag_name, "a")[20]
	  begin 
	  	e = driver.find_elements(:tag_name, "a")[19].attribute("href") if driver.find_elements(:tag_name, "a")[19].attribute("href")
	  	if e =~ /clickadv.asp/
	  		if wa < 5
		 		puts "#{x} #{e}"
		 		driver.find_elements(:tag_name, "a")[19].click
		 		sleep 5
		  		x=x+1
		  		sleep 5+Random.rand(1)
		  		wa = wa + 1
	  		else
	  			puts "skipping"
	  		end
	  	end
	  rescue
	  	next
	  end
	end

	puts "Robot.click: #{wa}"

	sleep 10

	next_page = driver.find_elements(:tag_name, "a")
	next_page.each do |link| 
  	#puts link.attribute("href") 
	  	if link.attribute("href") =~ /cads.asp\?page=2/
	  		page = 2
	  	else
	  		page = 1
	  	end
	end

	wb, adv_ids = today_bonus(driver)
	wa = wb
end

puts "Total clicks: #{wb}"
#driver.navigate.to("http://www.3plea.com/member/logout.asp")
#element.submit
#puts driver.title

#driver.quit
