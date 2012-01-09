require 'spec_helper'

describe ConcurConnect::Expense do
  describe '.from_hash' do
    it 'returns an Expense' do
      Expense.from_hash({}).should be_an(Expense)
    end
  end
end

