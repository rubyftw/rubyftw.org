require "rake/rdoctask"

task :default => [:site]
desc "Export site to live/ directory"
task :site => "site:default"

namespace :setup do
  task :default => [:bundler]

  desc "Checks bundle and installs anything missing"
  task :bundler do
    puts "Checking bundle and installing any missing dependencies"
    system "bundle check || bundle install"
  end
end

namespace :site do
  task :default => [:export]

  desc "Exports site to live/ directory"
  task :export => "setup:default" do
    puts "Exporting site to live/"
    system("rm -rf live; bundle exec frank export live")
  end

  desc "Exports site to live dir and publishes changes to live site"
  task :publish do
    puts "cleaning up temp directories"
    system %Q(ssh rubyftw@rubyftw.org "rm -rf /home/rubyftw/rubyftw.next")
    puts "publishing site to temp directory"
    system %Q(bundle exec frank publish)
    puts "moving current site to rubyftw.last and new changes to rubyftw.org"
    system %Q(ssh rubyftw@rubyftw.org "rm -rf /home/rubyftw.last 2>/dev/null; mv -f /home/rubyftw/rubyftw.org /home/rubyftw.last 2>/dev/null; mv -f /home/rubyftw/rubyftw.next /home/rubyftw/rubyftw.org")
    puts "Done!"
  end
end
