# coding: utf-8
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 're_track/version'

Gem::Specification.new do |s|
  s.name          = 're_track'
  s.version       = ReTrack::VERSION
  s.authors       = ['Gebhard Wöstemeyer']
  s.email         = ['g.woestemeyer@gmail.com']
  s.homepage      = 'https://github.com/gewo/re_track'
  s.summary       = 'Track HTTP-Referrers in Rails using Mongoid/MongoDB'
  s.description   = 'Track HTTP-Referrers in Rails using Mongoid/MongoDB'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.test_files    = s.files.grep(/^spec\//)
  s.require_paths = ['lib']

  s.add_runtime_dependency 'rails'
  s.add_runtime_dependency 'mongoid', '>= 4'
  s.add_runtime_dependency 'activesupport'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'appraisal'
  s.add_development_dependency 'rubocop'
end
