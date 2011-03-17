require 'ice_cube'
require 'active_support/core_ext'
#require 'active_support/core_ext/integer/inflections'

module FrankHelpers
  # helpers go here
  def title
    "Ruby FTW"
  end

  def group_epoch
    @epoch ||= Time.parse('2007-10-09 06:00pm')
  end

  def schedule
    unless @schedule
      @schedule = IceCube::Schedule.new(group_epoch)
      # Every 2nd Tuesday of the month
      @schedule.add_recurrence_rule IceCube::Rule.monthly.day_of_week(:tuesday => [2])
    end
    @schedule
  end

  def days_till_next_meeting
    Date.parse(schedule.next_occurrence.strftime("%Y-%m-%d")) - Date.today
  end

  def next_meeting
    time = schedule.next_occurrence
    "#{time.strftime("%A %B")} the #{time.strftime("%d").to_i.ordinalize}"
  end

  def twitter_link
    %Q(<a href="http://www.twitter.com/rubyftw"><img src="http://twitter-badges.s3.amazonaws.com/twitter-a.png" alt="Follow rubyftw on Twitter"/></a>)
  end

  def github_link
    %Q(<a href="http://github.com/rubyftw"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://d3nwyuy0nl342s.cloudfront.net/img/e6bef7a091f5f3138b8cd40bc3e114258dd68ddf/687474703a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f7265645f6161303030302e706e67" alt="Fork me on GitHub"></a>)
  end
end
