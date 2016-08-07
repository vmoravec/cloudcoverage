require "sinatra/base"
require 'sinatra/export'
require "forwardable"
require "pathname"
require "yaml"
require "awesome_print"
require "ostruct"
require "json"

require "cloudcoverage/version"
require "cloudcoverage/config"
require "cloudcoverage/resource"
require "cloudcoverage/resource/base"
require "cloudcoverage/resource/scenarios"

module Cloudcoverage
  class App
    attr_reader :config, :root, :resource

    def initialize params
      @root = params[:root]
      @config = Config.new(self)
      @resource = Resource
    end
  end

  def self.app *params
    @app ||= App.new(*params)
  end
end

