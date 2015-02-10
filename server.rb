require 'bundler' ; Bundler.require
use Rack::Logger

helpers do
  def logger
    request.logger
  end
end

set :port, 80
set :bind, '0.0.0.0'

#db = SQLite3::Database.new("file_url.db")

# By default Sinatra will return the string as the response.

#create = db.execute("create table url (url TEXT);")

get '/' do
  logger.info "loading data"
  "Hello World!!!"
  erb :form
end

get '/upload' do

end
