# frozen_string_literal: true

module DatabaseSchemaOwnership
  # :nodoc
  class Runner
    attr_reader :schema_path, :folder_path, :schema_extension

    def initialize(schema_path = "db/schema.rb", folder_path = "db/database_schema_ownership")
      @schema_path = schema_path
      @folder_path = folder_path
      @schema_extension = File.extname(schema_path)
    end

    def run
      parser = DatabaseSchemaOwnership::Parser.for(schema_extension).new(schema_path)
      entities = parser.parse

      FileUtils.mkdir_p(folder_path) if entities.any?

      entities.each do |entity|
        File.write(file_name(entity), entity.table)
      end
    end

    private

    def file_name(entity)
      "#{folder_path}/#{entity.name}#{schema_extension}"
    end
  end
end
