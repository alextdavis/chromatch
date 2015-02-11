class Chromatch < Sinatra::Base
  get '/api/expertise/:id' do
    login_required
    expertise = Expertise[params[:id]]
    expertise.to_json
  end

  post '/api/expertise/create' do
    login_required
    puts 'doing'
    puts params.inspect
    begin
      expertise = Expertise.create(params.pick_pairs(%w(statement source)).merge({:user => current_user}))
      puts expertise.inspect
    rescue Sequel::Error => e
      halt 403, e.message
    end
    expertise.to_json
  end

  post '/api/expertise/update/:id' do
    login_required
    begin
      expertise = Expertise.with_pk!(params[:id])
      owner_required expertise.user.id
      expertise.update(params.pick_pairs(%w(statement source)))
      expertise.to_json
    rescue Sequel::Error => e
      halt 403, e.message
    end
  end

  post '/api/expertise/delete/:id' do
    begin
      expertise = Expertise.with_pk!(params[:id])
      owner_required expertise.user.id
      expertise.destroy
      halt 200
    rescue Sequel::Error => e
      halt 403, e.message
    end
  end

  post '/api/bookark/create' do
    login_required
    begin
      bookmarking = Bookmarking.create(:bookmarker => current_user, :bookmarked => User.with_pk!(params[:user_id]))
    end
  end
end
