module Helpers
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
    "#{time.strftime("%A, %B")} the #{time.strftime("%d").to_i.ordinalize}"
  end

  def link(url, content)
    %Q(<a href="#{url}">#{content}</a>)
  end

  def group_link(content = "group")
    link "http://groups.google.com/group/rubyftw", content
  end

  def github_link(content = "github", options = {})
    options = ({:user => 'rubyftw', :repo => nil}).merge(options)
    path = [options[:user],options[:repo]].join('/').sub(/\/$/,'')
    link "https://github.com/#{path}", content
  end

  def twitter_link(content = "twitter")
    link "http://twitter.com/rubyftw", content
  end

  def fork_me
    github_link %Q(<img id="fork_me" src="https://d3nwyuy0nl342s.cloudfront.net/img/e6bef7a091f5f3138b8cd40bc3e114258dd68ddf/687474703a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f7265645f6161303030302e706e67" alt="Fork me on GitHub">)
  end

  def member_list
    html = %Q(<ul class="members">\n)
    HTTParty.get('http://github.com/api/v2/json/repos/show/rubyftw/rubyftw.org/watchers?full=1').parsed_response["watchers"].sort{|w,x| w["login"] <=> x["login"] }.each do |member|
      unless member["login"] == 'rubyftw'
        html << "\t<li>#{github_link gravatar(member["gravatar_id"], 48, :alt => member["login"], :title => member["name"]), :user => member["login"]}</li>\n"
      end
    end
    html << %Q(</ul>\n)
  end

  def gravatar(id, size = 48, html_options = {})
    img = %Q(<img src="https://secure.gravatar.com/avatar/#{id}?s=#{size}")
    html_options.each do |attr|
      img << %Q( #{attr[0].to_s}="#{attr[1].to_s}")
    end
    img << " />"
  end
end
