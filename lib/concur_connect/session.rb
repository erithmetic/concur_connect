require 'concur_connect/user_finder'
require 'delegate'
require 'faraday/request/oauth'
require 'faraday/response/parse_xml'

module ConcurConnect
  class Session < SimpleDelegator
    attr_accessor :consumer_key, :consumer_secret, :company_id, :debug

    def initialize(consumer_key, consumer_secret, company_id, debug = false)
      self.consumer_key = consumer_key
      self.consumer_secret = consumer_secret
      self.company_id = company_id
      self.debug = debug

      __setobj__ faraday  # wrap Faraday in a loving embrace
    end
    alias :debug? :debug

    def user_finder
      @user_finder ||= UserFinder.new self
    end

    def user(id)
      @user ||= user_finder.find id
    end

    def faraday
      Faraday.new(:url => 'https://www.concursolutions.com/api') do |builder|
        builder.request :OAuth, {
          :consumer_key => consumer_key,
          :consumer_secret => consumer_secret
        }
        builder.request  :url_encoded
        builder.request  :json
        builder.response :logger if debug?
        builder.adapter  :net_http

        builder.use Faraday::Response::ParseXml
      end
    end
  end
end
