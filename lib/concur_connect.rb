require "concur_connect/version"
require "concur_connect/session"

module ConcurConnect
  extend self

  def session(token, secret)
    Session.new token, secret
  end
end
