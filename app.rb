class Chromatch < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    Dir["./routes/*.rb"].each { |file| also_reload file }
    Dir["./helpers/*.rb"].each { |file| also_reload file }
  end

  register Sinatra::Flash

  use Rack::Session::Cookie, :key => 'rack.session',
      :expire_after               => 2592000,
      :secret                     => SecureRandom.hex(64)

  use OmniAuth::Builder do
    provider :google_oauth2, ENV['google_client_id'], ENV['google_client_secret'],
             {
                 :name               => 'google',
                 :prompt             => 'select_account',
                 :scopes             => 'email, plus.login',
                 :image_aspect_ratio => 'square',
                 :image_size         => 140,
                 :access_type        => 'offline'
             }
  end

  # before /^(\/$|\/login)/ do
  #   test
  # end
end
