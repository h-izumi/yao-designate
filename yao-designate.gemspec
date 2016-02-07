lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yao/designate/version'

Gem::Specification.new do |spec|
  spec.name          = 'yao-designate'
  spec.version       = Yao::Designate::VERSION
  spec.authors       = ['Kasumi Hanazuki']
  spec.email         = ['kasumi@rollingapple.net']

  spec.summary       = %q{Designate API binding for Yao}
  spec.description   = %q{Client for Designate, the DNSaaS component for OpenStack. Currently only partially supports Designate v1 API.}
  spec.homepage      = 'https://github.com/hanazuki/yao-designate'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split(?\x0).reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'yao', '~> 0.2.10'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.2.0'
end
