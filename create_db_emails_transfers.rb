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
    create_table :emails do |table|
        table.date :email_date
        table.boolean :sent, :default => false
        table.integer :typ, :default => 1
        table.timestamps
    end
end

ActiveRecord::Schema.define do
    create_table :transfers do |table|
        table.date :transfer_date
        table.string :account
        table.decimal :amount, :default => 0.00
        table.decimal :balance, :default => 0.00
        table.boolean :status, :default => false
        table.timestamps
    end
end        
=begin
=end

