module DatabaseSchemaOwnership
  class Runner
    def run
      # parse the schema file
      parser = DatabaseSchemaOwnership::Parser.new
      entities = parser.parse

      # create directory
      FileUtils.mkdir_p('db/database_schema_ownership') if entities.any?
      # split tables between files
      entities.each do |entity|
        File.open("db/database_schema_ownership/#{entity.name}.rb", 'w') do |f|
          f.write(entity.table)
        end
      end
    end
  end
end