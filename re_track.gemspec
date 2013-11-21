# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 're_track/version'

Gem::Specification.new do |s|
  s.name        = 're_track'
  s.version     = ReTrack::VERSION
  s.authors     = ['Gebhard Wöstemeyer']
  s.email       = ['g.woestemeyer@gmail.com']
  s.homepage    = 'https://github.com/gewo/re_track'
  s.summary     = "Track HTTP-Referrers in Rails using Mongoid/MongoDB"
  s.description = "Track HTTP-Referrers in Rails using Mongoid/MongoDB"
  s.license     = 'MIT'

  s.files       = Dir['{app,config,db,lib}/**/*'] +
                  ['MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails'
  s.add_dependency 'mongoid', '>= 3'
  s.add_dependency 'activesupport'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'appraisal'
end
