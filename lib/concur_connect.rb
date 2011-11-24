require "concur_connect/version"
require "concur_connect/session"

module ConcurConnect
  extend self

  def session(token, secret, company_id)
    Session.new token, secret, company_id
  end
end
