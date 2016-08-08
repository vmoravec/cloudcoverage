require "bundler/gem_tasks"
require "rspec/core/rake_task"

Bundler.require

RSpec::Core::RakeTask.new(:spec)

task :default => :help

app = Cloudcoverage.app(root: Pathname.new(__dir__))

require "cloudcoverage/assets"

namespace :repos do
  desc "Download all repos"
  task :pull do
    app.config["repos"].each do |repo|
      base_path = Pathname.new(File.join("vendor", "git"))
      repo_path = base_path.join(repo["name"])
      if repo_path.exist?
        puts "Doing git pull from remote repo #{repo["url"]}"
        cd base_path.join(repo["name"])
        system "git pull origin master"
      else
        puts "Cloning repo '#{repo["name"]}'"
        system "git clone #{repo["url"]} vendor/git/#{repo["name"]}"
      end
    end
  end
end

namespace :scenarios do
  desc "List all scenarios"
  task :list do
    ap app.resource.get(:scenarios, filter: :current_cloud_version)
  end
end

desc "Show config"
task :config do
  ap app.config.content
end

desc "Help"
task :help do
  puts `rake -T`
end


desc "Run"
task :run do
  pid = Process.spawn('bundle exec rackup')
  puts "Got #{pid} process id"
  sleep 5
  puts system "curl localhost:9292"
  Process.kill(15, pid)
end

namespace :assets do
  desc "Compile application assets"
  task :compile do
    Cloudcoverage::Assets.precompile
  end
end

