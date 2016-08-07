class SinatraApp < Sinatra::Base
  set :views, "#{__dir__}/templates/"

  register Sinatra::Export

  get "/" do
    puts settings.root
    slim :index
  end
end
