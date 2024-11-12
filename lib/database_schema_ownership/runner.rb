# frozen_string_literal: true

module DatabaseSchemaOwnership
  # :nodoc
  class Runner
    def run
      # parse the schema file
      parser = DatabaseSchemaOwnership::Parser.new
      entities = parser.parse

      # create directory
      FileUtils.mkdir_p("db/database_schema_ownership") if entities.any?
      # split tables between files
      entities.each do |entity|
        File.write("db/database_schema_ownership/#{entity.name}.rb", entity.table)
      end
    end
  end
end
