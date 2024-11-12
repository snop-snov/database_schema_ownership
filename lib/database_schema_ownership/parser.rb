# frozen_string_literal: true

module DatabaseSchemaOwnership
  class Parser # :nodoc:
    def parse
      entities = []

      schema = File.read("db/schema.rb")

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
