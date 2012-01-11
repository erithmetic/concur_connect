require 'spec_helper'

describe ConcurConnect::ExpenseFinder do
  let(:session) { 
    ConcurConnect.session '3dcPjZyTeQziAndLnUALTI', 'ZipGipKjsd4ypFx2qcJ5sCuBY9FYbJlE', 't0026855k9r8'
  }
  let(:finder) { ConcurConnect::ExpenseFinder.new session }

  describe '#find' do
    it 'gets a list of expense reports with a given status' do
      VCR.use_cassette('expense list') do
        list = finder.find('https://www.concursolutions.com:443/api/expense/expensereport/v1.1/report/nABR4fUZDftz3veYYzMffJR5k3uLU7xQy')
        list.should_not be_empty
        list.each { |i| i.should be_a(ConcurConnect::Expense) }
      end
    end
  end

  describe '#build_expenses' do
    it 'handles an empty list of expenses' do
      ers = finder.build_expenses({'ExpenseEntriesList' => nil})
      ers.should be_empty
    end
    it 'builds a list of a single expense' do
      ers = finder.build_expenses({'ExpenseEntriesList' => {
        'ExpenseEntrySummary' => {
          'ApprovedAmount' => '678.00000000', 
          'Expense-Entry-Url' => 'http://www.concursolutions.com/api/expense/expensereport/v1.1/report/iiwEUE87weOisd2sF2hsq/entry/Irusj23j48hks9IIor92746SLL92039jfyd', 
          'ExpenseName' => 'Advertising', 
          'LocationName' => 'Redmond, Washington', 
          'TransactionAmount' => '678.00000000', 
          'TransactionCrnCode' => 'USD', 
          'VendorDescription' => nil,
          'VendorListName' => 'The Daily Herald'
      }}})
      ers.should_not be_empty
      ers.each do |expense|
        expense.should be_a(ConcurConnect::Expense)
        expense.type.length.should > 0
        expense.amount.to_f.should > 0
        expense.vendor.length.should > 0
      end
    end
    it 'builds a list of new expenses' do
      ers = finder.build_expenses({'ExpenseEntriesList' => {
        'ExpenseEntrySummary' => [{
          'ApprovedAmount' => '678.00000000', 
          'Expense-Entry-Url' => 'http://www.concursolutions.com/api/expense/expensereport/v1.1/report/iiwEUE87weOisd2sF2hsq/entry/Irusj23j48hks9IIor92746SLL92039jfyd', 
          'ExpenseName' => 'Advertising', 
          'LocationName' => 'Redmond, Washington', 
          'TransactionAmount' => '678.00000000', 
          'TransactionCrnCode' => 'USD', 
          'VendorDescription' => nil,
          'VendorListName' => 'The Daily Herald'
      },
      {
          'ApprovedAmount' => '778.00000000', 
          'Expense-Entry-Url' => 'http://www.concursolutions.com/api/expense/expensereport/v1.1/report/iiwEUE87weOisd2sF2hsq/entry/Irusj23j48hks9IIor92746SLL92039jfye', 
          'ExpenseName' => 'Gas', 
          'LocationName' => 'Tacoma, Washington', 
          'TransactionAmount' => '778.00000000', 
          'TransactionCrnCode' => 'USD', 
          'VendorDescription' => nil,
          'VendorListName' => 'The Daily Herald'
      }
      ]}})
      ers.should_not be_empty
      ers.each do |expense|
        expense.should be_a(ConcurConnect::Expense)
        expense.type.length.should > 0
        expense.amount.to_f.should > 0
        expense.vendor.length.should > 0
      end
    end
  end
end

