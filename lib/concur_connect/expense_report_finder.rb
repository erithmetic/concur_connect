require "concur_connect/expense_finder"
require 'concur_connect/expense_report'
require 'concur_connect/finder'

module ConcurConnect
  class ExpenseReportFinder
    include Finder

    STATUSES = %w{RECENT UNSUBMITTED PENDING APPROVED PROCESSED PAID
      PAYMENTCONFIRMED FORTHISMONTH FORLASTMONTH FORTHISQUARTER
      FORLASTQUARTER FORTHISYEAR FORLASTYEAR TOAPPROVE APPROVEDTHISMONTH
      APPROVEDLASTMONTH APPROVEDTHISQUARTER APPROVEDLASTQUARTER
      APPROVEDTHISYEAR APPROVEDLASTYEAR}
    
    # status: status string defined in STATUSES
    # date: a Date/Time object for filtering
    def find(user_id = nil, status = 'APPROVED', date = nil)
      url = "/api/expense/expensereport/v1.1/reportslist/#{status}"
      url += "/LastModified?date=#{date.strftime('%Y-%m-%d')}" if date
      response = session.get url do |g|
        g.headers['X-UserID'] = user_id if user_id
      end
      build_expense_reports response.body
    end

    def build_expense_reports(data)
      list = []
      if data['ReportsList'] && data['ReportsList']['ReportSummary']
        items = data['ReportsList']['ReportSummary']
        items = [items] unless items.is_a?(Array)
        items.each do |datum|
          expense_report = ExpenseReport.new
          expense_report.id = datum['ReportId']
          expense_report.name = datum['ReportName']
          expense_report.date = datum['ReportDate']
          list << expense_report
        end
      end
      list
    end
  end
end
