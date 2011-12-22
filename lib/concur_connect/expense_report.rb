require 'concur_connect/expense_finder'

module ConcurConnect
  class ExpenseReport
    attr_accessor :id, :name, :date, :details_url,
      :expenses,
      :session

    def expense_finder
      @expense_finder ||= ExpenseFinder.new session
    end

    def api_id
      File.basename details_url
    end

    def expenses
      @expenses ||= expense_finder.find api_id
    end
  end
end
