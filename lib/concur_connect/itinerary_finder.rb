require 'concur_connect/itinerary'

module ConcurConnect
  class ItineraryFinder
    attr_accessor :session

    def initialize(session)
      self.session = session
    end

    def find(user_id, start_date = nil)
      url = 'travel/trip/v1.0/'
      url += "?startDate=#{start_date.strftime('%Y-%m-%d')}" if start_date
      response = session.get url do |g|
        g.headers['X-UserID'] = user_id
      end
      build_itineraries response.body
    end

    def build_itineraries(data)
      list = []
      if data['ItineraryInfoList'] && data['ItineraryInfoList']['ItineraryInfo']
        data['ItineraryInfoList']['ItineraryInfo'].each do |datum|
          itinerary = Itinerary.new
          itinerary.concur_id = datum['id']
          itinerary.name = datum['TripName']
          itinerary.start_date = datum['StartDateLocal']
          itinerary.end_date = datum['EndDateLocal']
          list << itinerary
        end
      end
      list
    end
  end
end
