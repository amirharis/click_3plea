in_minute = 600
x = 0
loop do
  if x == in_minute
     %x{killall 'Google Chrome'}   
     %x{killall chromedriver}
     x = 0 
  else
     x = x + 30
  end
  puts x
sleep 30
end
