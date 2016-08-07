require "bundler/setup"

Bundler.require(:default)

require 'logger'

logger = Logger.new(STDOUT)
use Rack::CommonLogger, logger

Cloudcoverage.app(root: Pathname.new(__dir__))

require "cloudcoverage/sinatra_app"
require "cloudcoverage/assets"

run Rack::Cascade.new [ SinatraApp, Assets ]
