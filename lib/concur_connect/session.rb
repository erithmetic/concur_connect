require "concur_connect/expense_report_finder"
require "concur_connect/itinerary_finder"
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
      @user_finder = UserFinder.new self
      @expense_report_finder = ExpenseReportFinder.new self

      faraday = Faraday.new(:url => 'https://www.concursolutions.com/api') do |builder|
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
      __setobj__ faraday  # wrap Faraday in a loving embrace
    end
    alias :debug? :debug

    def user(id)
      @user ||= @user_finder.find id
    end

    def expense_reports(user_id, date, status = 'APPROVED')
      @expense_reports ||= @expense_report_finder.find user_id, status, date
    end
  end
end
