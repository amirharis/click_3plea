class Testme
   @@x = 1
   def self.wow
       b = 1
       1.upto(3) do |x|
         puts @@x=@@x+1
       end     
   end
   
   def self.sing
      1.upto(3) do |x|
        self.wow 
      end
   end
end

Testme.sing
