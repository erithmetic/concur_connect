require 'concur_connect/user'

module ConcurConnect
  class UserManager
    attr_accessor :session

    def initialize(session)
      self.session = session
    end

    def find(company, user)
      response = session.get 'user/v1.0/User' do |g|
        g.headers['X-CompanyDomain'] = company
        g.headers['X-UserID'] = user
      end
      User.from_concur response
    end
  end
end
