# frozen_string_literal: true

module DatabaseSchemaOwnership
  class Parser
    class SqlParser < Parser # :nodoc:
      def rules
        [
          # ActiveRecord 8
          /(CREATE TABLE IF NOT EXISTS "([^"]*)"[^;]*;)/m,
          /(CREATE INDEX .* ON "([^"]*)"[^;]*;)/,

          # early versions
          /(CREATE TABLE (\S+) \([^;]*;)/m,
          /(CREATE INDEX \S+ ON (\S+) USING [^;]*;)/,
          /(CREATE UNIQUE INDEX \S+ ON (\S+) USING [^;]*;)/,
          /(ALTER TABLE ONLY (\S+)[^;]*;)/m
        ]
      end
    end
  end
end
