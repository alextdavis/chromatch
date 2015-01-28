class Chromatch < Sinatra::Base
  get '/' do
    erb :home
  end
end
