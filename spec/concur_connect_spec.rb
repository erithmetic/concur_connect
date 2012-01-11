require 'spec_helper'

describe ConcurConnect do
  it 'is easy to use' do
    concur = ConcurConnect.session '3dcPjZyTeQziAndLnUALTI', 'ZipGipKjsd4ypFx2qcJ5sCuBY9FYbJlE', 't0026855k9r8'
    concur.should be_a(ConcurConnect::Session)
    user = nil
    expense_reports = nil

    VCR.use_cassette 'session expense reports'  do
      expense_reports = concur.expense_reports 'derek.kastner@brighterplanet.com', Date.new(2011, 9, 1)
      expense_reports.should_not be_empty
    end

    expenses = nil
    VCR.use_cassette 'session expenses'  do
      expenses = expense_reports.first.expenses
      expenses.should_not be_empty
    end

    VCR.use_cassette 'session expense details'  do
      expenses.first.transaction_date.should be_a(Date)
    end

    VCR.use_cassette 'session user'  do
      user = concur.user('derek.kastner@brighterplanet.com')
      user.should be_a(ConcurConnect::User)
    end

    #VCR.use_cassette('session user expense reports', :record => :once) do
      #reports = user.expense_reports
      #reports.should_not be_empty
    #end
  end
end
