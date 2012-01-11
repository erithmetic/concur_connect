require 'bundler'
Bundler.setup

require 'concur_connect'

require 'vcr'
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.stub_with :fakeweb, :faraday
  c.default_cassette_options = { :record => :new_episodes }
end
