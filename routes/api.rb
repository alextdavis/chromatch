class Chromatch < Sinatra::Base
  get '/api/expertise/:id' do
    expertise = Expertise[params[:id]]
    expertise.to_json
  end

  post '/api/expertise/create' do
    puts 'doing'
    puts params.inspect
    begin
      expertise = Expertise.create(params.pick_pairs(%w(statement source)).merge({:user => current_user}))
    rescue Sequel::Error => e
      halt 403, e.message
    end
    expertise.to_json
  end

  post '/api/expertise/update/:id' do
    begin
      expertise = Expertise.with_pk!(params[:id])
      halt 403, "Permission Denied" unless is_owner? expertise.user.id
      expertise.update(params.pick_pairs(%w(statement source)))
    rescue Sequel::Error => e
      halt 403, e.message
    end
    expertise.to_json
  end

  post '/api/expertise/delete/:id' do
    begin
      expertise = Expertise.with_pk!(params[:id])
      halt 403, "Permission Denied" unless is_owner? expertise.user.id
      expertise.destroy
      halt 200
    rescue Sequel::Error => e
      halt 403, e.message
    end
  end

  get '/api/bookmarks' do
      current_user.bookmarks_dataset.select(:id).to_json
  end

  post '/api/bookmark/toggle' do
    if current_user.has_bookmarked(params[:user_id])
      begin
        current_user.remove_bookmark(User.with_pk!(params[:user_id]))
        halt 200
      # rescue Sequel::Error => e
      #   halt 403, e.message
      end
      return "false"
    else
      begin
        current_user.add_bookmark(User.with_pk!(params[:user_id]))
      # rescue Sequel::Error => e
      #   halt 403, e.message
      end
      return "true"
    end
  end

  post '/api/bookmark/create' do
    begin
      current_user.bookmarks.create(:bookmarker => current_user, :bookmarked => User.with_pk!(params[:user_id]))
    rescue Sequel::Error => e
      halt 403, e.message
    end
    bookmarking.to_json
  end

  post '/api/bookmark/delete/:id' do
    begin
      bookmarking = Bookmarking.with_pk!(params[:id])
      halt 403, "Permission Denied" unless is_owner? bookmarking.bookmarker.id
      bookmarking.destroy
      halt 200
    rescue Sequel::Error => e
      halt 403, e.message
    end
  end
end
