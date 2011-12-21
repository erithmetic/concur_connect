require 'concur_connect/user'

module ConcurConnect
  class UserFinder
    attr_accessor :session

    def initialize(session)
      self.session = session
    end

    def find(id)
      response = session.get 'user/v1.0/User' do |g|
        g.headers['X-CompanyDomain'] = session.company_id
        g.headers['X-UserID'] = id
      end
      build_user response.body
    end

    def build_user(response)
      user = User.new
      user.login_id = response['LoginId']
      user.first_name = response['FirstName']
      user.last_name = response['LastName']
      user
    end
  end
end
