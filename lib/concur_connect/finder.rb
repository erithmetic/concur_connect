require 'time'
require 'date'

module ConcurConnect
  module Finder
    def self.included(target)
      target.extend ClassMethods
    end

    module ClassMethods
      def parse_boolean(val)
        val == 'Y'
      end

      def parse_date(val)
        Date.parse val
      end

      def parse_time(val)
        Time.parse val
      end
    end

    attr_accessor :session

    def initialize(session)
      self.session = session
    end
  end
end
