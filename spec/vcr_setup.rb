require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.stub_with :faraday
  c.default_cassette_options = { :record => :once }
end
