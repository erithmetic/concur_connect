require 'concur_connect/expense'
require 'concur_connect/finder'

module ConcurConnect
  class ExpenseFinder
    include Finder
    
    def find(expense_report_url)
      response = session.get expense_report_url + '/entries'
      build_expenses response.body
    end

    def build_expenses(data)
      list = []
      if data['ExpenseEntriesList'] && data['ExpenseEntriesList']['ExpenseEntrySummary']
        items = data['ExpenseEntriesList']['ExpenseEntrySummary']
        items = [items] unless items.is_a?(Array)
        items.each do |datum|
          expense = Expense.new :session => session, :details_url => datum['Expense_Entry_Url'],
            :type => datum['ExpenseName'], :amount => datum['TransactionAmount'],
            :vendor => datum['VendorListName']
          list << expense
        end
      end
      list
    end
  end
end
