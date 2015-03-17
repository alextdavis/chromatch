class Chromatch < Sinatra::Base
  get '/home' do
    erb :home
  end

  get '/profile' do
    erb :profile
  end

  get '/search' do
    erb :search
  end

  get '/bookmarks' do
    @bookmarkings = Bookmarkings.where(:bookmarker_id => current_user.id)
    erb :bookmarks
  end

  get '/results' do
    erb :results_list
  end

  post '/results/more' do
    @items = [{id: 2, name: "MOAR John Doe", avatar: "//placehold.it/100", phone: "(123) 456-7890", info: "There will be text here"},
              {id: 3, name: "MOAR Jane Doe", avatar: "//placehold.it/100", phone: "(123) 456-7891", info: "This is about Jane Doe"},
              {id: 4, name: "Winnie the Pooh", avatar: "http://cdnvideo.dolimg.com/cdn_assets/c94eed56a5e84479a2939c9172434567c0147d4f.jpg", phone: "(123) 456-7892", info: "PhD. in Honey Consumption", bookmarked: true}]
    erb :results_items, :layout => false
  end

  get '/browse' do
    @items = User.select(:id, :name, :avatar, :phone).limit(10)

    erb :results_list
  end

end
