# frozen_string_literal: true

module DatabaseSchemaOwnership
  class Parser
    class SqlParser < Parser # :nodoc:
      def rules
        [
          /(CREATE TABLE IF NOT EXISTS "([^"]*)"[^;]*;)/m,
          /(CREATE INDEX .* ON "([^"]*)"[^;]*;)/
        ]
      end
    end
  end
end
