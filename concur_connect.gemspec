$:.push File.expand_path("../lib", __FILE__)
require 'concur_connect/version'

Gem::Specification.new do |s|
  s.name = 'concur_connect'
  s.version = ConcurConnect::VERSION
  s.platform = Gem::Platform::RUBY
  s.date = '2011-10-13'
  s.authors = ['Derek Kastner']
  s.email = 'dkastner@gmail.com'
  s.homepage = 'http://github.com/dkastner/concur_connect'
  s.summary = %Q{TODO: one-line summary of your gem}
  s.description = %Q{TODO: detailed description of your gem}
  s.extra_rdoc_files = [
    'LICENSE',
    'README.rdoc',
  ]

  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.7')
  s.rubygems_version = '1.3.7'
  s.specification_version = 3

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'faraday', '~> 0.6.0'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'simple_oauth'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'bueller'
  s.add_development_dependency 'fakeweb'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rcov'
  s.add_development_dependency 'vcr'
end

