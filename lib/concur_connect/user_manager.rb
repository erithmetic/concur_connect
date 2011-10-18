require 'concur_connect/user'

module ConcurConnect
  class UserManager
    attr_accessor :session

    def initialize(session)
      self.session = session
    end

    def in_batches
      response = session.get '/Users'
      user = User.from_concur response
      yield user
    end
  end
end
