require 'spec_helper'

describe ConcurConnect::Expense do
  let(:session) { 
    ConcurConnect.session '3dcPjZyTeQziAndLnUALTI', 'ZipGipKjsd4ypFx2qcJ5sCuBY9FYbJlE', 't0026855k9r8'
  }
  let(:expense) { ConcurConnect::Expense.new :session => session }
  let(:details) { mock(ConcurConnect::ExpenseDetail) }

  it 'proxies #date to its ExpenseDetails object' do
    expense.stub!(:details).and_return details
    details.should_receive :transaction_date
    expense.transaction_date
  end
end

