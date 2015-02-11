class Chromatch < Sinatra::Base
  get '/home' do
    erb :home
  end

  get '/profile' do
    login_required

    erb :profile
  end

  get '/search' do
    login_required

    erb :search
  end

  get '/bookmarks' do
    login_required

    @bookmarkings = Bookmarkings.where(:bookmarker_id => current_user.id)
    erb :bookmarks
  end
  post '/api/expertise/potato' do
    puts 'doing'
  end
end
