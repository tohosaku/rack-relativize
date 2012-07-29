# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rack/relativize/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["tohosaku"]
  gem.email         = ["ny@cosmichorror.org"]
  gem.description   = %q{rack-relativize relativize path of html ( href, src attribute) and css ( url(..) ). }
  gem.summary       = %q{rack-relativize relativize path of html ( href, src attribute) and css ( url(..) ). }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rack-relativize"
  gem.require_paths = ["lib"]
  gem.version       = Rack::Relativize::VERSION
end
