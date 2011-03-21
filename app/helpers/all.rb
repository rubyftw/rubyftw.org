require 'app/helpers/github_helper'
require 'app/helpers/gravatar_helper'
require 'app/helpers/link_helper'
require 'app/helpers/meeting_helper'

module RubyFtw
    module Helpers
      HELPERS = [GravatarHelper,
                GithubHelper,
                LinkHelper,
                MeetingHelper]
      HELPERS.each{|helper| include helper }
  end
end
