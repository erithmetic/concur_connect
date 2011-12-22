require 'concur_connect/session'
require 'concur_connect/version'

module ConcurConnect
  extend self

  def session(token, secret, company_id)
    Session.new token, secret, company_id
  end
end
