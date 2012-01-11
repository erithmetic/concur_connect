module ConcurConnect
  class ExpenseDetail < DataItem
    attr_accessor :approved_amount, :business_purpose, :e_receipt_id,
        :exchange_rate, :key, :name, :allocated, :attended, :commented,
        :exceptional, :value_added_taxed, :image_required, :charged_by_credit_card,
        :itemized, :personal, :personal_card_charge, :last_modified, :location,
        :payment_type, :posted_amount, :receipt_image_id, :receipt_required,
        :report_entry_id, :report_id, :transaction_amount, :transaction_currency,
        :transaction_date, :vendor_description

    alias :allocated? :allocated
    alias :attended? :attended
    alias :commented? :commented
    alias :exceptional? :exceptional
    alias :value_added_taxed? :value_added_taxed
    alias :image_required? :image_required
    alias :charged_by_credit_card? :charged_by_credit_card
    alias :itemized? :itemized
    alias :personal? :personal
    alias :personal_card_charge? :personal_card_charge
    alias :receipt_required? :receipt_required
  end
end
