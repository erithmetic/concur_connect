require 'spec_helper'

describe ConcurConnect::ExpenseReportFinder do
  let(:session) { 
    ConcurConnect.session '3dcPjZyTeQziAndLnUALTI', 'ZipGipKjsd4ypFx2qcJ5sCuBY9FYbJlE', 't0026855k9r8'
  }
  let(:finder) { ConcurConnect::ExpenseReportFinder.new session }

  describe '#find' do
    it 'gets a list of expense reports with a given status' do
      VCR.use_cassette('expense_report list by status') do
        list = finder.find('derek.kastner@brighterplanet.com', 'APPROVED')
        list.should_not be_empty
        list.each { |i| i.should be_a(ConcurConnect::ExpenseReport) }
      end
    end
    it 'gets a list of expense reports with a given status and last modified date' do
      VCR.use_cassette('expense_report list by date') do
        list = finder.find(nil, 'APPROVED', Time.new(2012,1,16))
        list.should_not be_empty
        list.each { |i| i.should be_a(ConcurConnect::ExpenseReport) }
      end
    end
  end

  describe '#build_expense_reports' do
    it 'handles an empty list of expense reports' do
      ers = finder.build_expense_reports({'ReportsList' => nil})
      ers.should be_empty
    end
    it 'builds a list of a single expense report' do
      ers = finder.build_expense_reports({'ReportsList' => {
        'ReportSummary' => {
          'ReportName' => 'August Expenses',
          'ReportTotal' => '245.00000000',
          'ReportId' => '14B7C9053CAA4864A27F',
          'ReportDate' => '2010-08-06T00:00:00',
          'LastComment' => '',
          'Report-Details-Url' => 'http://www.concursolutions.com/api/expense/expensereport/v1.1/report/ndfsdfseSDFDwaXZesdsfs',
          'Report-Full-Details-Url' => 'http://www.concursolutions.com/api/expense/expensereport/v1.1/reportfulldetails/ndfsdfseSDFDwaXZesdsfs'
      }}})
      ers.should_not be_empty
      ers.each do |expense_report|
        expense_report.should be_a(ConcurConnect::ExpenseReport)
        expense_report.id.should =~ /^[A-F0-9]+$/
        expense_report.name.should == 'August Expenses'
        expense_report.date.should =~ /\d{4}-\d\d-\d\d/
      end
    end
    it 'builds a list of new expense reports' do
      ers = finder.build_expense_reports({'ReportsList' => {
        'ReportSummary' => [{
          'ReportName' => 'August Expenses',
          'ReportTotal' => '245.00000000',
          'ReportId' => '14B7C9053CAA4864A27F',
          'ReportDate' => '2010-08-06T00:00:00',
          'LastComment' => '',
          'Report-Details-Url' => 'http://www.concursolutions.com/api/expense/expensereport/v1.1/report/ndfsdfseSDFDwaXZesdsfs',
          'Report-Full-Details-Url' => 'http://www.concursolutions.com/api/expense/expensereport/v1.1/reportfulldetails/ndfsdfseSDFDwaXZesdsfs'
      },
      {
          'ReportName' => 'September Expenses',
          'ReportTotal' => '345.00000000',
          'ReportId' => '14B7C9053CAA4864A27F',
          'ReportDate' => '2011-09-06T00:00:00',
          'LastComment' => '',
          'Report-Details-Url' => 'http://www.concursolutions.com/api/expense/expensereport/v1.1/report/ndfsdfseSDFDwaXZesdsfs',
          'Report-Full-Details-Url' => 'http://www.concursolutions.com/api/expense/expensereport/v1.1/reportfulldetails/ndfsdfseSDFDwaXZesdsfs'
      }
      ]}})
      ers.should_not be_empty
      ers.each do |expense_report|
        expense_report.should be_a(ConcurConnect::ExpenseReport)
        expense_report.id.should =~ /^[A-F0-9]+$/
        expense_report.name.length.should > 0
        expense_report.date.should =~ /\d{4}-\d\d-\d\d/
      end
    end
  end
end

