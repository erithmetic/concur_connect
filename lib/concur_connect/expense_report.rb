require 'concur_connect/expense_finder'

module ConcurConnect
  class ExpenseReport
    attr_accessor :id, :name, :date,
      :expenses,
      :session

    def expense_finder
      @expense_finder ||= ExpenseFinder.new session
    end

    def expenses
      @expenses ||= expense_finder.find id
    end
  end
end
