require 'spec_helper'
require 'concur_connect/expense_detail_finder'

describe ConcurConnect::ExpenseDetailFinder do
  let(:session) { 
    ConcurConnect.session '3dcPjZyTeQziAndLnUALTI', 'ZipGipKjsd4ypFx2qcJ5sCuBY9FYbJlE', 't0026855k9r8'
  }
  let(:finder) { ConcurConnect::ExpenseDetailFinder.new session }

  describe '#find' do
    it "gets an expense's details" do
      VCR.use_cassette('expense details', :record => :once) do
        detail = finder.find('nABR4fUZDftz3veYYzMffJR5k3uLU7xQy', 'n7w$pAOZByd82Y9p6KwXMFISMo1mcNqatX')
        detail.should be_a(ConcurConnect::ExpenseDetail)
      end
    end
  end
end
