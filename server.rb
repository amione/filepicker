require 'bundler' ; Bundler.require
use Rack::Logger

helpers do
  def logger
    request.logger
  end
end

set :port, 8000
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

post "/upload" do
	puts params
	filepicker_blob = params
	filepicker_url = filepicker_blob["filepicker_url"]
	db = SQLite3::Database.new("urls.db")
	write = db.execute("insert into urls(url) values (#{filepicker_url})")
end
