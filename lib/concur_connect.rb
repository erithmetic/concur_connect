require 'concur_connect/session'
require 'concur_connect/version'

# ConcurConnect makes using the Concur Connect API
# a breeze to use.
#
# Quick start:
#
#     concur = ConcurConnect.session 'token', 'secret', 'company ID'
#     reports = concur.expense_reports Date.new(2011, 9, 1)  # all approved reports since 9/1/2011
#     puts reports.first.expenses.inspect
module ConcurConnect
  extend self

  # Start a connection session to ConcurConnect
  #
  # token: OAuth token
  # secret: OAuth secret
  # company_id: your ConcurConnect company ID (usually your domain)
  def session(token, secret, company_id)
    Session.new token, secret, company_id
  end
end
