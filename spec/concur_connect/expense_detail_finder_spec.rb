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
        detail = finder.find 'https://www.concursolutions.com/api/expense/expensereport/v1.1/report/nABR4fUZDftz3veYYzMffJR5k3uLU7xQy/entry/n7w$pAOZByd82Y9p6KwXMFISMo1mcNqatX'
        detail.should be_a(ConcurConnect::ExpenseDetail)
        detail.approved_amount.should == 179.82
        detail.business_purpose.should be_nil
        detail.e_receipt_id.should be_nil
        detail.exchange_rate.should == 1.0
        detail.key.should == 'MILEG'
        detail.name.should == 'Personal Car Mileage'
        detail.should_not be_allocated
        detail.should_not be_attended
        detail.should_not be_commented
        detail.should be_exceptional
        detail.should_not be_value_added_taxed
        detail.should_not be_image_required
        detail.should_not be_charged_by_credit_card
        detail.should_not be_itemized
        detail.should_not be_personal
        detail.should_not be_personal_card_charge
        detail.last_modified.should == Time.new(2011, 12, 22, 15, 15, 10)
        detail.location.should be_nil
        detail.payment_type.should == 'CASH'
        detail.posted_amount.should == 179.82
        detail.receipt_image_id.should be_nil
        detail.should_not be_receipt_required
        detail.report_entry_id.should == 'n7w$pAOZByd82Y9p6KwXMFISMo1mcNqatX'
        detail.report_id.should == 'nABR4fUZDftz3veYYzMffJR5k3uLU7xQy'
        detail.transaction_amount.should == 179.82
        detail.transaction_currency.should == 'US, Dollar'
        detail.transaction_date.should == Date.new(2011, 11, 23)
        detail.vendor_description.should be_nil
      end
    end
  end
end
