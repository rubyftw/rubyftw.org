require "rake/rdoctask"

task :default => [:site]
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
  task :default => [:hack]

  desc "Start a server on port 3601"
  task :hack => "setup:default" do
    exec "bundle exec frank server"
  end

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
    system %Q(ssh rubyftw@rubyftw.org "rm -rf /home/rubyftw/rubyftw.last 2>/dev/null; mv -f /home/rubyftw/rubyftw.org /home/rubyftw/rubyftw.last 2>/dev/null; mv -f /home/rubyftw/rubyftw.next /home/rubyftw/rubyftw.org")
    puts "Done!"
  end

  desc "Pull updates from github and rebuild site, runs from cron every 30 mins"
  task :update do
    puts "Checking for updates from github.."
    if `git pull` !~ /up-to-date/ or ENV['FORCE']
      puts "  Great, new stuff!"
      Rake::Task["site:export"].invoke
      if File.exist?("live/index.html")
        if File.exist?("/home/rubyftw/rubyftw.next")
          system %Q(rm -rf /home/rubyftw/rubyftw.next)
        end
        if File.exist?("/home/rubyftw/rubyftw.last")
          system %Q(rm -rf /home/rubyftw/rubyftw.last)
        end
        system %Q(mv -f /home/rubyftw/rubyftw.org /home/rubyftw/rubyftw.last; mv -f live /home/rubyftw/rubyftw.org)
	      puts " site replaced"
      end
    else
      puts "Nothing new.."
    end
  end
end
