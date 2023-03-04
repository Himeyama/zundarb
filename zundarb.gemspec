# frozen_string_literal: true

require_relative 'lib/zundarb/version'

Gem::Specification.new do |spec|
  spec.name = 'zundarb'
  spec.version = Zundarb::VERSION
  spec.authors = ['MURATA Mitsuharu']
  spec.email = ['hikari.photon+git@gmail.com']

  spec.summary = 'Generate voicebox audio from text.'
  spec.description = 'Generate and play audio by calling VOICEVOX\'s speech synthesis engine API.'
  spec.license = 'MIT'
  # spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.required_ruby_version = '>= 2.6.0'

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"
  # spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Himeyama/zundarb'
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'win32-sound', '~> 0.6.2'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 1.47'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
