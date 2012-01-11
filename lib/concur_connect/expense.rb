require 'concur_connect/data_item'
require 'concur_connect/expense_detail_finder'

module ConcurConnect
  class Expense < DataItem
    attr_accessor :type, :amount, :vendor, :transaction_date, :session, :details_url

    def details
      return @details unless @details.nil?
      finder = ExpenseDetailFinder.new session
      @details ||= finder.find(details_url)
    end

    def transaction_date; details.transaction_date; end
  end
end
