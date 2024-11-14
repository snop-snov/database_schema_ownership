# frozen_string_literal: true

require_relative "lib/database_schema_ownership/version"

Gem::Specification.new do |spec| # rubocop:disable Gemspec/RequireMFA
  spec.name = "database_schema_ownership"
  spec.version = DatabaseSchemaOwnership::VERSION
  spec.authors = ["Evgeniy Demin"]
  spec.email = ["lawliet.djez@gmail.com"]

  spec.summary = "Provide an easy way to manage code ownership over a database schema."
  spec.homepage = "https://github.com/djezzzl/database_schema_ownership"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/djezzzl/database_schema_ownership"
  spec.metadata["changelog_uri"] = "https://github.com/djezzzl/database_schema_ownership/blob/master/CHANGELOG.md"

  spec.files = Dir["lib/**/*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord"
end
