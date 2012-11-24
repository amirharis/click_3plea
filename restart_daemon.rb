in_minute = 900
x = 0
loop do
  if x == in_minute
  	#This is for OSX
    %x{killall 'Google Chrome'}   
    %x{killall chromedriver}
    x = 0 
  else
    x = x + 30
  end
  puts x
sleep 30
end