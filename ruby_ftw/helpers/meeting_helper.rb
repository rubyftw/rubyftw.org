module RubyFtw
  module Helpers
    module MeetingHelper
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
    end
  end
end