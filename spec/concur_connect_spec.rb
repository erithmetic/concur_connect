require 'spec_helper'
require 'vcr_setup'

describe ConcurConnect do
  it 'is easy to use' do
    concur = ConcurConnect.session '3dcPjZyTeQziAndLnUALTI', 'ZipGipKjsd4ypFx2qcJ5sCuBY9FYbJlE', 't0026855k9r8'
    concur.should be_a(ConcurConnect::Session)
    user = nil

    VCR.use_cassette('user', :record => :once) do
      user = concur.user('derek.kastner@brighterplanet.com')
      user.should be_a(ConcurConnect::User)
    end

    VCR.use_cassette('user expense reports', :record => :once) do
      reports = user.expense_reports
      reports.should_not be_empty
    end

    #trips = concur.trips.find 'example.com', 'bob@example.com'
    #trips.each  { |trip| trip.should be_a(ConcurConnect::Trip) }
    #trips = concur.trips.find 'example.com', 'bob@example.com', :start_date => Date.now
    #trips.each  { |trip| trip.should be_a(ConcurConnect::Trip) }
  end
end
