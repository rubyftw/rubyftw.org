module RubyFtw
  module Helpers
    module MiscHelper
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
  end
end