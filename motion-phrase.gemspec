# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'motion-phrase/version'

Gem::Specification.new do |gem|
  gem.name          = "motion-phrase"
  gem.version       = MotionPhrase::VERSION
  gem.authors       = ["PhraseApp"]
  gem.email         = ["info@phraseapp.com"]
  gem.description   = "RubyMotion library for PhraseApp"
  gem.summary       = "Connect your RubyMotion application to PhraseApp for the best i18n experience"
  gem.homepage      = "https://github.com/phrase/motion-phrase"
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'phrase'
  gem.add_dependency 'afmotion'
  gem.add_dependency 'bubble-wrap'
  gem.add_dependency 'motion-cocoapods'
  gem.add_development_dependency 'rake'
end
