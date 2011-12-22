module ConcurConnect
  module Finder
    attr_accessor :session

    def initialize(session)
      self.session = session
    end
  end
end
