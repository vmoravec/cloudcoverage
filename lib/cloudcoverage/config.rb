module Cloudcoverage
  class Config
    extend Forwardable
    def_delegators :@content, :[], :merge!

    attr_reader :app, :content

    DIR = "config"
    DEFAULT = "default.yaml"

    def initialize app
      @app = app
      @content = Hash.new
      load_files
    end

    def cloud_versions
      self["cloud"]["versions"]
    end

    def current_cloud_version
      cloud_versions.first
    end

    def repos_dir
      app.root.join(self["repos_dir"])
    end

    private

    def load_files
      path = app.root.join(DIR)
      content.merge!(
        YAML.load_file(path.children.find {|p| p.to_s.match(DEFAULT) })
      )
    end
  end
end
