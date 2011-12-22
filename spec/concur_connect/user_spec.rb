require 'spec_helper'
require 'concur_connect/user'
require 'concur_connect/expense_report'

describe ConcurConnect::User do
  #describe '#itineraries' do
    #let(:user) { ConcurConnect::User.new }
    #it 'fetches all itineraries for the user if no date is specified' do
      #user.itineraries
    #end
    #it 'fetches all itineraries for the user after a specified date'
  #end

  describe '#expense_reports' do
    it 'fetches all the expense reports for the user' do
      pending
      u.expense_reports.should_not be_empty
      u.expense_reports.each { |er| er.should be_a?(ExpenseReport) }
    end
  end
end
