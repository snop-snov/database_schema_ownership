module DatabaseSchemaOwnership
  class Parser
    def parse
      entities = []

      schema = File.open("db/schema.rb").read

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
