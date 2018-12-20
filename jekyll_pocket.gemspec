lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll_pocket/version'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll_pocket'
  spec.version       = JekyllPocket::VERSION
  spec.authors       = ['Marii']
  spec.email         = ['m.nyrop@columbia.edu']

  spec.summary       = 'jekyll hook plugin for building a fully portable site'
  spec.homepage      = 'https://github.com/mnyrop/jekyll_pocket'
  spec.license       = 'MIT'
  
  spec.required_ruby_version = '~> 2.4'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'html-proofer', '>= 3.8', '< 4.0'
  spec.add_runtime_dependency('jekyll', '>= 3.7', '< 4.0')

  spec.add_development_dependency 'bundler', '>= 1.16', '< 1.18'
  spec.add_development_dependency 'colorize', '~> 0.8'
  spec.add_development_dependency 'minima', '~> 2.5'
  spec.add_development_dependency 'rspec', '>= 3.0', '< 4.0'
  spec.add_development_dependency 'rubocop', '>= 0.60', '< 0.70'
  spec.add_development_dependency 'yard', '~> 0.9'
end
