class Chromatch < Sinatra::Base
  post '/api/expertise/:id' do
    expertise = Expertises[id]
    expertise.to_json
  end

  post '/api/expertise/create' do
    expertise = Expertises.create()
  end

end
