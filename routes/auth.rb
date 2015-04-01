class Chromatch < Sinatra::Base
  get '/login' do
    redirect '/auth/google'
  end

  get '/logout' do
    redirect '/auth/logout'
  end

  %w(get post).each do |method|
    send(method, '/auth/:provider/callback') do
      info = request.env['omniauth.auth'].info.to_hash
      uid = request.env['omniauth.auth'].uid
      puts info.inspect

      halt 500 unless info['email']

      halt 403, 'You must have a valid account issued by the Westport Public Schools to use this site' unless /^([a-z]{2}\d{5,7}@students.|[a-z]{3,}@)westport.k12.ct.us$/ =~ info['email']

      unless user = User.first(:uid => uid)
        user       = User.new
        user.uid   = uid
        user.email = info['email']
        user.name  = info['name']
        user.avatar = info['image']
      end

      halt 500 unless user.save

      user.generate_token
      session[:user] = user.token

      flash[:success] = 'You have successfully logged in!'
      redirect '/home'
    end
  end

  get '/auth/failure' do
    session.clear

    flash[:error] = 'Authentication error occurred.'
    redirect '/'
  end

  get '/auth/logout' do
    session.clear

    flash[:info] = 'Successfully logged out.'
    redirect '/'
  end
end
