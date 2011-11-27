# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-dbdc/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-dbdc"
  s.version     = Omniauth::Dbdc::VERSION
  s.authors     = ["Thomas Stachl"]
  s.email       = ["thomas@stachl.me"]
  s.homepage    = "https://github.com/sseforce/omniauth-dbdc"
  s.summary     = "Force.com/Database.com RESTful API OAuth2 Strategy for OmniAuth"
  s.description = "Force.com/Database.com RESTful API OAuth2 Strategy for OmniAuth"

  s.rubyforge_project = "omniauth-dbdc"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "omniauth", "~> 1.0"
  s.add_dependency "omniauth-oauth2", "~> 1.0"
  s.add_development_dependency 'rspec', '~> 2.7'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'
end
