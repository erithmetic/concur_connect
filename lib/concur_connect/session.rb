require 'concur_connect/user_manager'
require 'delegate'
require 'faraday/request/oauth'

module ConcurConnect
  class Session < SimpleDelegator
    attr_accessor :consumer_key, :consumer_secret, :debug

    def initialize(consumer_key, consumer_secret, debug = false)
      self.consumer_key = consumer_key
      self.consumer_secret = consumer_secret
      self.debug = debug

      __setobj__ faraday  # wrap Faraday in a loving embrace
    end
    alias :debug? :debug

    def users
      @users ||= UserManager.new self
    end

    def faraday
      Faraday.new(:url => 'https://www.concursolutions.com/api') do |builder|
        builder.request :OAuth, {
          :consumer_key => consumer_key,
          :consumer_secret => consumer_secret
        }
        builder.request  :json
        builder.response :logger if debug?
        builder.adapter  :net_http
      end
    end
  end
end
