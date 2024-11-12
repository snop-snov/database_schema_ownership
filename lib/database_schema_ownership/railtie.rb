# frozen_string_literal: true

module DatabaseSchemaOwnership
  class Railtie < Rails::Railtie # :nodoc:
    rake_tasks do
      load "#{__dir__}/database_schema_ownership.rake"
    end
  end
end
