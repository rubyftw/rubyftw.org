require 'ruby_ftw/helpers/link_helper'
require 'ruby_ftw/helpers/meeting_helper'
require 'ruby_ftw/helpers/misc_helper'

module RubyFtw
  module Helpers
    include LinkHelper
    include MeetingHelper
    include MiscHelper
  end
end
