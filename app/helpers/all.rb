require 'app/helpers/link_helper'
require 'app/helpers/meeting_helper'
require 'app/helpers/misc_helper'

module RubyFtw
  module Helpers
    include LinkHelper
    include MeetingHelper
    include MiscHelper
  end
end
