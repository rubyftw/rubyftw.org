module RubyFtw
  module Helpers
    module LinkHelper
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
    end
  end
end