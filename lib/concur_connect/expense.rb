require 'concur_connect/data_item'
require 'concur_connect/expense_detail_finder'
require 'forwardable'

module ConcurConnect
  class Expense < DataItem
    extend Forwardable

    attr_accessor :type, :amount, :vendor, :transaction_date, :session, :details_url
    def_delegators :details, *(ExpenseDetail::ATTRIBUTES + ExpenseDetail::ALIASES.keys)

    def details
      return @details unless @details.nil?
      finder = ExpenseDetailFinder.new session
      @details ||= finder.find(details_url)
    end
  end
end
