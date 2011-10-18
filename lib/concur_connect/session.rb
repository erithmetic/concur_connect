require 'concur_connect/user_manager'
require 'delegate'
require 'faraday/request/oauth'

module ConcurConnect
  class Session < SimpleDelegator
    attr_accessor :token, :secret, :debug

    def initialize(token, secret, debug = false)
      self.token = token
      self.secret = secret
      self.debug = debug

      __setobj__ faraday  # wrap Faraday in a loving embrace
    end
    alias :debug? :debug

    def users
      @users ||= UserManager.new self
    end

    def faraday
      Faraday.new(:url => 'https://www.concursolutions.com/api/user/v1.0') do |builder|
        builder.request :OAuth, :token => '3dcPjZyTeQziAndLnUALTI'
          #:token_secret => 'ZipGipKjsd4ypFx2qcJ5sCuBY9FYbJlE'
        builder.request  :json
        builder.response :logger if debug?
        builder.adapter  :net_http
      end
    end
  end
end
