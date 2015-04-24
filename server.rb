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

post "/upload" do
	puts params
	filepicker_blob = params
	@filepicker_url = filepicker_blob["filepicker_url"].to_s
	puts @filepicker_url
	db = SQLite3::Database.new("urls.db")
	last_id = db.execute("select id from urls order by id desc")
	new_id = last_id[0][0].to_i + 1
	write = db.execute("insert into urls(url, id) values ('#{@filepicker_url}', #{new_id})")
	@get_list = db.execute('select * from urls order by id asc')
	@last_in_array = last_id[0][0].to_i - 1
	for x in 0..@last_in_array.to_i
	  puts "#{@get_list[x][1]} #{@get_list[x][0]}"
    end
	erb :url
end

get '/upload' do
	db = SQLite3::Database.new("urls.db")
	last_url = db.execute("select url from urls order by id desc")
	last_id = db.execute("select id from urls order by id desc")
	@last_image = last_url[0][0].to_s
	@get_list = db.execute('select * from urls order by id asc')
	@last_in_array = last_id[0][0].to_i - 1
	for x in 0..@last_in_array.to_i
	  puts "#{@get_list[x][1]} #{@get_list[x][0]}"
    end
	erb :last
end