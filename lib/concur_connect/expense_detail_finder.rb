require 'concur_connect/expense_detail'
require 'concur_connect/finder'

module ConcurConnect
  class ExpenseDetailFinder
    include Finder

    def find(report_id, expense_id)
      url = "/api/expense/expensereport/v1.1/report/#{report_id}/entry/#{expense_id}"
      response = session.get url
      build_expense_detail response
    end

    def build_expense_detail(data)
      ExpenseDetail.new :data => data['ExpenseEntry']
    end
  end
end
