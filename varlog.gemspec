lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'varlog/version'

Gem::Specification.new do |spec|
  spec.name          = 'varlog'
  spec.version       = Varlog::VERSION
  spec.summary       = ''
  spec.authors       = ["RC", "Sunil"]

  spec.files         = `git ls-files`.split($/)
  spec.require_paths = ['lib']
end
