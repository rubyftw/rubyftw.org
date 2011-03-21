module RubyFtw
  module Helpers
    module GithubHelper
      def member_list(portrait_size = 48)
        html = %Q(<ul class="members">\n)
        HTTParty.get('http://github.com/api/v2/json/repos/show/rubyftw/rubyftw.org/watchers?full=1').parsed_response["watchers"].sort{|w,x| w["login"] <=> x["login"] }.each do |member|
          unless member["login"] == 'rubyftw'
            html << "\t<li>#{github_link gravatar(member["gravatar_id"], portrait_size, :alt => member["login"], :title => member["name"]), :user => member["login"]}</li>\n"
          end
        end
        html << %Q(</ul>\n)
      end
    end
  end
end