#coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name = "fastspring-saasy"
  s.version = "0.6.2"

  s.authors = ["Richard Patching"]
  s.email = "richard@justaddpixels.com"
  s.description = "Ruby lib for using the FastSpring (SaaSy) subscription management API"
  s.summary = "Ruby lib for using the FastSpring (Saasy) API"
  s.homepage = "http://github.com/patchfx/fastspring-saasy"

  s.files = `git ls-files`.split($/)
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})

  s.add_dependency "httparty", "~> 0.10.0", ">= 0.10.0"
  s.add_dependency "gyoku", "~> 1.0.0", ">= 1.0.0"

  s.add_development_dependency "rake", ">= 10.0.3", "~> 12.3.3"
  s.add_development_dependency "rspec", "~> 2.12.0", ">= 2.12.0"
  s.add_development_dependency "webmock", "~> 1.9.0", ">= 1.9.0"
end
