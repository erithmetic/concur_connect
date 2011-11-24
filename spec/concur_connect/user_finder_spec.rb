require 'spec_helper'

describe ConcurConnect::UserFinder do
  let(:session) { 
    ConcurConnect.session '3dcPjZyTeQziAndLnUALTI', 'ZipGipKjsd4ypFx2qcJ5sCuBY9FYbJlE', 't0026855k9r8'
  }
  let(:finder) { ConcurConnect::UserFinder.new session }

  describe '#find' do
    it 'finds and builds a user' do
      VCR.use_cassette('user', :record => :once) do
        user = finder.find('derek.kastner@brighterplanet.com')
        user.should be_a(ConcurConnect::User)
      end
    end
  end

  describe '#build_user' do
    it 'builds a new user' do
      u = finder.build_user({'LoginId' => 'user@example.com'})
      u.should be_a(ConcurConnect::User)
      u.login_id.should == 'user@example.com'
    end
  end
end

