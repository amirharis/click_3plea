require 'rubygems'
require 'active_record'

=begin
ActiveRecord::Base.establish_connection(
  :adapter=> "mysql",
  :host => "localhost",
  :database=> "bind"
)
=end
#:password if you have password dude

#ActiveRecord::Base.logger = Logger.new(STDERR)
#ActiveRecord::Base.colorize_logging = false

#ActiveRecord::Base.establish_connection adapter:'mysql2',username:'root',password:'', database: 'mysql'
#ActiveRecord::Base.connection.create_database "3plea"


ActiveRecord::Base.establish_connection(
    :adapter => "mysql2",  
    :host => "localhost",  
    :database => "3plea",
    :username => "root",
    :password => ""
)


#ActiveRecord::Base.connection.create_database("3plea")

ActiveRecord::Schema.define do
    create_table :states do |table|
        table.date :click_date
        table.string :process
        table.boolean :state, :default => 0
        table.timestamps
    end
end
        
=begin
=end

