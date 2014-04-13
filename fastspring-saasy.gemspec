#coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name = "fastspring-saasy"
  s.version = "0.6.0"

  s.authors = ["Richard Patching"]
  s.email = "richard@justaddpixels.com"
  s.description = "Ruby lib for using the FastSpring (SaaSy) subscription management API"
  s.summary = "Ruby lib for using the FastSpring (Saasy) API"
  s.homepage = "http://github.com/patchfx/fastspring"

  s.files = `git ls-files`.split($/)
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})

  s.add_dependency "httparty"
  s.add_dependency "gyoku"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "webmock"
end

