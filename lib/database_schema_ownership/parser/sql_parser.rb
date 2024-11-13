# frozen_string_literal: true

module DatabaseSchemaOwnership
  class Parser
    class SqlParser < Parser # :nodoc:
      def parse
        parse_tables + parse_indexes
      end

      def parse_tables
        schema.scan(/(CREATE TABLE IF NOT EXISTS "([^"]*)"[^;]*;)/m).map do |s|
          DatabaseSchemaOwnership::Entity.new(s[1], s[0])
        end
      end

      def parse_indexes
        schema.scan(/(CREATE INDEX .* ON "([^"]*)"[^;]*;)/).map do |s|
          DatabaseSchemaOwnership::Entity.new(s[1], s[0])
        end
      end
    end
  end
end
