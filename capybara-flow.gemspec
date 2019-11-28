# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "capybara-flow"
  spec.version       = File.read("VERSION")
  spec.authors       = ["Stitch Fix"]
  spec.email         = ["eng@stitchfix.com"]
  spec.description   = %q{Composes GIF animations from screenshots taken after capybara specified user actions.}
  spec.summary       = %q{Gif animations of your headless browser tests.}
  spec.homepage      = "https://github.com/stitchfix/capybara-flow"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capybara"
  spec.add_dependency "rmagick"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
end
