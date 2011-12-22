require 'concur_connect/expense_report'

module ConcurConnect
  class User
    attr_accessor :login_id, :first_name, :last_name, :email,
      :country_code, :currency_code, :country_sub_code,
      :session

    def expense_reports(status = 'APPROVED', date = nil)
      @expense_reports ||= expense_report_finder.find(login_id, status, date)
    end

    def expense_report_finder
      @expense_report_finder ||= ExpenseReportFinder.new session
    end
  end
end
