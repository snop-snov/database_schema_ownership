module DatabaseSchemaOwnership
  class Parser
    # TODO: add support for FKs
    class RubyParser
      attr_accessor :schema_path

      def initialize(schema_path)
        @schema_path = schema_path
      end

      def parse
        entities = []

        schema = File.read(schema_path)

        schema.scan(/\n*(\s+create_table "([^"]*)".*?end)/m).each do |table|
          entity = DatabaseSchemaOwnership::Entity.new

          entity.table = table[0]
          entity.name = table[1]

          entities << entity
        end

        entities
      end
    end
  end
end