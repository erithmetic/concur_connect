require 'concur_connect/data_item'

module ConcurConnect
  class Expense < DataItem
    attr_accessor :type, :amount, :vendor
  end
end
