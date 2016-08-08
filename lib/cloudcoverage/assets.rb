require "sprockets"
require "sass"

module Cloudcoverage
  class Assets < Sinatra::Base
    set :root, Cloudcoverage.app.root
    set :assets, Sprockets::Environment.new(settings.root)

    configure do
      dir = "assets"
      assets.append_path "#{dir}/javascripts"
      assets.append_path "#{dir}/stylesheets"
      assets.append_path "#{dir}/images"
      assets.append_path "#{dir}/fonts"
      assets.css_compressor = :scss
      assets.register_engine '.jst', Sprockets::JstProcessor, mime_type: 'application/javascript'
    end

    get '/assets/*' do
      env['PATH_INFO'].sub!(%r{^/assets}, '')
      settings.assets.call(env)
    end

    def self.precompile
      loose_app_assets = Proc.new do |path, filename|
        filename !~ %r~app/assets~  && !%w[.js .css].include?(File.extname(path))
      end
      precompile = [loose_app_assets, /(?:\/|\\|\A)application\.(css|js)$/]
      settings.assets.each_logical_path(*precompile).each do |path|
          settings.assets[path].write_to settings.root.join("public", "assets", path)
      end
    end

  end
end
