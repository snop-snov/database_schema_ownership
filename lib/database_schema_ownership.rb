# frozen_string_literal: true

require_relative "database_schema_ownership/version"
require_relative "database_schema_ownership/entity"
require_relative "database_schema_ownership/parser"
require_relative "database_schema_ownership/runner"

require_relative "database_schema_ownership/railtie" if defined?(Rails)

module DatabaseSchemaOwnership # :nodoc:
end
