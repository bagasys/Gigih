require 'mysql2'

def create_db_client
  client = Mysql2::Client.new(
    :host => "localhost",
    :username => "gigih",
    :password => "password",
    :database => "hwm2s3"
  )
  client
end