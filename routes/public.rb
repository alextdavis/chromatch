class Chromatch < Sinatra::Base
  get '/' do
    erb :public
  end
end
