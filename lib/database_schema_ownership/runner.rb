# frozen_string_literal: true

module DatabaseSchemaOwnership
  # :nodoc
  class Runner
    RUBY_SCHEMA_PATH = "db/schema.rb"
    SQL_SCHEMA_PATH = "db/structure.sql"
    OWNERSHIP_PATH = "db/database_schema_ownership"

    attr_reader :schema_path, :folder_path, :schema_extension

    def initialize(schema_path = nil, folder_path = OWNERSHIP_PATH)
      @schema_path = schema_path || find_schema_path
      @folder_path = folder_path
      @schema_extension = File.extname(@schema_path)
    end

    def run
      parser = DatabaseSchemaOwnership::Parser.for(schema_extension).new(schema_path)
      entities = parser.parse

      FileUtils.mkdir_p(folder_path) if entities.any?

      grouped = entities.each_with_object({}) do |entity, hash|
        if hash[entity.name]
          hash[entity.name] += "\n#{entity.metadata}"
        else
          hash[entity.name] = entity.metadata
        end
      end

      grouped.each do |name, metadata|
        File.write(file_name(name), metadata)
      end
    end

    private

    def file_name(name)
      "#{folder_path}/#{name}#{schema_extension}"
    end

    def find_schema_path
      if File.exist?(RUBY_SCHEMA_PATH)
        RUBY_SCHEMA_PATH
      elsif File.exist?(SQL_SCHEMA_PATH)
        SQL_SCHEMA_PATH
      else
        raise "Schema file not found"
      end
    end
  end
end
