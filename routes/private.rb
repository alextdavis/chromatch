class Chromatch < Sinatra::Base
  get '/profile' do
    login_required

    erb :profile
  end

  get '/search' do
    login_required

    erb :search
  end

  get 'bookmarks' do
    login_required

    @bookmarkings = Bookmarkings.where(:bookmarker_id => current_user.id)
    erb :bookmarks
  end
end
