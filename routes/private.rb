class Chromatch < Sinatra::Base
  get '/home' do
    erb :home
  end

  get '/profile' do
    erb :profile
  end

  get '/profile/edit' do
    erb :profile_edit
  end

  post '/profile/update' do
    puts params.inspect

    redirect '/profile'
  end

  get '/search' do
    erb :search
  end

  get '/bookmarks' do
    @bookmarkings = Bookmarkings.where(:bookmarker_id => current_user.id)
    erb :bookmarks
  end

end