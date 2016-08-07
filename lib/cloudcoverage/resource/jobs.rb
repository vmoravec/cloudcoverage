module Cloudcoverage
  module Resource
    class Jobs < Base
      self.resource_key = :jobs

      def default
        ssl_types = app.config["scenarios"]["ssl_type"]
        scenario_files = app.config["scenarios"]["files"]

        default_data = []
        app.config.cloud_versions.each do |cloud_version|
          ssl_types.each do |ssl|
            files = []

            scenario_files.map do |attr|
              full_path = app.config.repos_dir.join(attr["repo"], attr["path"])
              path_to_s = full_path.to_s
              replace_ssl_type(path_to_s, ssl)
              replace_cloud_version(path_to_s, cloud_version)
              specific_path = Pathname.new(path_to_s)
              files.concat(specific_path.children) if specific_path.exist?
            end

            files.each do |file|
              scenario = {}
              scenario["cloud"] = cloud_version
              scenario["ssl"] = ssl
              scenario["file"] = file.to_s
              default_data << scenario
            end
          end
        end

        self.loaded = true
        update(default_data)
      end

      def current_cloud_version
        present(
          values.select {|r| r["cloud"] == app.config.current_cloud_version}
        )
      end

      private

      def replace_cloud_version path, version=app.config.current_cloud_version
        path.gsub!(/@@cloud_version@@/, version.to_s)
      end

      def replace_ssl_type path, type
        path.gsub!(/@@ssl_type@@/, type.to_s)
      end
    end
  end
end
