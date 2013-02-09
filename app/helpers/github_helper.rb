module RubyFtw
  module Helpers
    module GithubHelper
      def member_list(portrait_size = 48)
        html = %Q(<ul class="members">\n)
        HTTParty.get('https://api.github.com/orgs/rubyftw/members').parsed_response.sort{|w,x| w["login"] <=> x["login"] }.each do |member|
          unless member["login"] == 'rubyftw'
            html << "\t<li>#{github_link gravatar(member["gravatar_id"], portrait_size, :alt => member["login"], :title => member["login"]), :user => member["login"]}</li>\n"
          end
        end
        html << %Q(</ul>\n)
      rescue => uh_oh
        '<ul class="members"></ul>'
      end
    end
  end
end
