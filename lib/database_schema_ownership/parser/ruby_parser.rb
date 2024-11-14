# frozen_string_literal: true

module DatabaseSchemaOwnership
  class Parser
    class RubyParser < Parser # :nodoc:
      def rules
        [
          /\n*(\s+create_table "([^"]*)".*?end)/m,
          /\n*(\s+add_foreign_key "([^"]*)", "([^"]*)")/
        ]
      end
    end
  end
end
