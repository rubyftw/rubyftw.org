require "rake/rdoctask"

task :default => [:frank]
desc "Export site to live/ directory"
task :frank => "frank:default"

namespace :frank do
  task :default => [:export]

  desc "Exports site to live/ directory"
  task :export do
    puts "Exporting site to live/"
    exec("rm -rf live; bundle exec frank export live")
  end

  desc "Exports site to live dir and publishes changes to live site"
  task :publish do
    export
    exec("bundle exec frank publish")
  end
end
