require 'open-uri'
require 'nokogiri'
 
doc = Nokogiri::HTML(open("http://www.3plea.com/memberLogin.asp"))
arr = Array.new
#doc.xpath('//tr/td').each do |node|
x = 1
doc.xpath('//input/@name').each do |node|
   unless node.nil?
     arr << node
     puts node
   end
end
#h = Hash[*arr.flatten] 
#puts h
#puts arr.count
#puts doc
