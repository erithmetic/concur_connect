require 'concur_connect/expense_detail'
require 'concur_connect/finder'

module ConcurConnect
  class ExpenseDetailFinder
    include Finder

    def find(url)
      response = session.get url
      build_expense_detail response.body
    end

    def build_expense_detail(data)
      item = data['ExpenseEntry']
      ExpenseDetail.new :approved_amount => item['ApprovedAmount'].to_f,
        :business_purpose => item['BusinessPurpose'],
        :e_receipt_id => item['EreceiptId'],
        :exchange_rate => item['ExchangeRate'].to_f,
        :key => item['ExpenseKey'],
        :name => item['ExpenseName'],
        :allocated => self.class.parse_boolean(item['HasAllocation']),
        :attended => self.class.parse_boolean(item['HasAttendees']),
        :commented => self.class.parse_boolean(item['HasComments']),
        :exceptional => self.class.parse_boolean(item['HasExceptions']),
        :value_added_taxed => self.class.parse_boolean(item['HasVat']),
        :image_required => self.class.parse_boolean(item['ImageRequired']),
        :charged_by_credit_card => self.class.parse_boolean(item['IsCreditCharge']),
        :itemized => self.class.parse_boolean(item['IsItemized']),
        :personal => self.class.parse_boolean(item['IsPersonal']),
        :personal_card_charge => self.class.parse_boolean(item['IsPersonalCardCharge']),
        :last_modified => self.class.parse_time(item['LastModified']),
        :location => item['LocationName'],
        :payment_type => item['PaymentTypeKey'],
        :posted_amount => item['PostedAmount'].to_f,
        :receipt_image_id => item['ReceiptImageId'],
        :report_entry_id => item['ReportEntryID'],
        :report_id => item['ReportID'],
        :transaction_amount => item['TransactionAmount'].to_f,
        :transaction_currency => item['TransactionCurrencyName'],
        :transaction_date => self.class.parse_date(item['TransactionDate']),
        :vendor_description => item['VendorDescription']
    end
  end
end
