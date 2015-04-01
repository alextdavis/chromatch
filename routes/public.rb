class Chromatch < Sinatra::Base
  get '/' do
    redirect '/home' if logged_in?
    erb :public, :layout => false
  end
end
