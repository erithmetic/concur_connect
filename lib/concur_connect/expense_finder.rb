require 'concur_connect/expense'
require 'concur_connect/finder'

module ConcurConnect
  class ExpenseFinder
    include Finder
    
    def find(report_id)
      url = "/api/expense/expensereport/v1.1/report/#{report_id}/entries"
      response = session.get url
      build_expenses response.body
    end

    def build_expenses(data)
      list = []
      if data['ExpenseEntriesList'] && data['ExpenseEntriesList']['ExpenseEntrySummary']
        items = data['ExpenseEntriesList']['ExpenseEntrySummary']
        items = [items] unless items.is_a?(Array)
        items.each do |datum|
          expense = Expense.new
          expense.type = datum['ExpenseName']
          expense.amount = datum['TransactionAmount']
          expense.vendor = datum['VendorListName']
          list << expense
        end
      end
      list
    end
  end
end
