require 'spec_helper'
require 'concur_connect/user'

describe ConcurConnect::User do
  describe '.from_concur' do
    it 'builds a new user' do
      u = ConcurConnect::User.from_concur {}
      u.should be_a(ConcurConnect::User)
      u.concur_id.should = 1
    end
  end
end
