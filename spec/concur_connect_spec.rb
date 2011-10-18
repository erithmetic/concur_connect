require 'spec_helper'
require 'vcr_setup'

describe ConcurConnect do
  it 'is easy to use' do
    concur = ConcurConnect.session 'ABC123', 'XYZ321'
    concur.should be_a(ConcurConnect::Session)

    VCR.use_cassette('users') do
      concur.users.in_batches do |user|
        user.should be_a(ConcurConnect::User)
      end
    end

    trips = concur.trips.find 'example.com', 'bob@example.com'
    trips.each  { |trip| trip.should be_a(ConcurConnect::Trip) }
    trips = concur.trips.find 'example.com', 'bob@example.com', :start_date => Date.now
    trips.each  { |trip| trip.should be_a(ConcurConnect::Trip) }
  end
end
