require 'mysql2'

def create_db_client
  client = Mysql2::Client.new(
    :host => '127.0.0.1',
    :username => 'gigih',
    :password => 'password',
    :database => 'hwm2s3'
  )
  client
end