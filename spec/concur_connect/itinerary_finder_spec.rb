require 'spec_helper'

describe ConcurConnect::ItineraryFinder do
  let(:session) { 
    ConcurConnect.session '3dcPjZyTeQziAndLnUALTI', 'ZipGipKjsd4ypFx2qcJ5sCuBY9FYbJlE', 't0026855k9r8'
  }
  let(:finder) { ConcurConnect::ItineraryFinder.new session }

  describe '#find' do
    it 'finds and builds a list of itineraries' do
      VCR.use_cassette('itinerary list', :record => :once) do
        list = finder.find('derek.kastner@brighterplanet.com')
        list.should_not be_empty
        list.each { |i| i.should be_a(ConcurConnect::Itinerary) }
      end
    end
  end

  describe '#build_itineraries' do
    it 'handles an empty list of itineraries' do
      is = finder.build_itineraries({'ItineraryInfoList' => nil})
      is.should be_empty
    end
    it 'builds a list of new itineraries' do
      is = finder.build_itineraries({'ItineraryInfoList' => {
        'ItineraryInfo' => [{
          'id' => 'https://www.concursoultions.com/api/travel/trip/v1.0/4294967509',
          'TripName' => 'My Trip',
          'StartDateLocal' => '2010-02-15T09:00:00',
          'EndDateLocal' => '2010-02-15T09:00:00'
      }]}})
      is.should_not be_empty
      is.each do |itinerary|
        itinerary.should be_a(ConcurConnect::Itinerary)
        itinerary.concur_id.should =~ /http/
        itinerary.name.should =~ /\w+/
        itinerary.start_date.should =~ /\d{4}-\d\d-\d\d/
        itinerary.end_date.should =~ /\d{4}-\d\d-\d\d/
      end
    end
  end
end

