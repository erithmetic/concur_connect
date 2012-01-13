module ConcurConnect
  class ExpenseDetail < DataItem
    ATTRIBUTES = [:approved_amount, :business_purpose, :e_receipt_id,
      :exchange_rate, :key, :name, :allocated, :attended, :commented,
      :exceptional, :value_added_taxed, :image_required, :charged_by_credit_card,
      :itemized, :personal, :personal_card_charge, :last_modified, :location,
      :payment_type, :posted_amount, :receipt_image_id, :receipt_required,
      :report_entry_id, :report_id, :transaction_amount, :transaction_currency,
      :transaction_date, :vendor_description]
    ALIASES = {:allocated? => :allocated,
               :attended? => :attended,
               :commented? => :commented,
               :exceptional? => :exceptional,
               :value_added_taxed? => :value_added_taxed,
               :image_required? => :image_required,
               :charged_by_credit_card? => :charged_by_credit_card,
               :itemized? => :itemized,
               :personal? => :personal,
               :personal_card_charge? => :personal_card_charge,
               :receipt_required? => :receipt_required }

    attr_accessor *ATTRIBUTES

    ALIASES.each do |question, attribute|
      send :alias_method, question, attribute
    end
  end
end
