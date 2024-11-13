module DatabaseSchemaOwnership
  class Parser
    class RubyParser < Parser # :nodoc:
      def parse
        parse_tables + parse_foreign_keys
      end

      def parse_tables
        schema.scan(/\n*(\s+create_table "([^"]*)".*?end)/m).map do |s|
          DatabaseSchemaOwnership::Entity.new(s[1], s[0])
        end
      end

      def parse_foreign_keys
        schema.scan(/\n*(\s+add_foreign_key "([^"]*)", "([^"]*)")/).flat_map do |s|
          [
            DatabaseSchemaOwnership::Entity.new(s[1], s[0]),
            DatabaseSchemaOwnership::Entity.new(s[2], s[0])
          ]
        end
      end
    end
  end
end