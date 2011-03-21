module RubyFtw
  module Helpers
    module GravatarHelper
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