require 'spec_helper'
require 'vcr_setup'

describe ConcurConnect do
  it 'is easy to use' do
    concur = ConcurConnect.session '3dcPjZyTeQziAndLnUALTI', 'ZipGipKjsd4ypFx2qcJ5sCuBY9FYbJlE'
    concur.should be_a(ConcurConnect::Session)

    VCR.use_cassette('GET user/v1.0/User', :record => :all) do
      user = concur.users.find('t0026855k9r8','derek.kastner@brighterplanet.com')
      user.should be_a(ConcurConnect::User)
    end

    #trips = concur.trips.find 'example.com', 'bob@example.com'
    #trips.each  { |trip| trip.should be_a(ConcurConnect::Trip) }
    #trips = concur.trips.find 'example.com', 'bob@example.com', :start_date => Date.now
    #trips.each  { |trip| trip.should be_a(ConcurConnect::Trip) }
  end
end
