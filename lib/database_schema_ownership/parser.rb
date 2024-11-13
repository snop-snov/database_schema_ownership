# frozen_string_literal: true

module DatabaseSchemaOwnership
  class Parser # :nodoc:
    def self.for(extension)
      case extension
      when ".rb" then RubyParser
      when ".sql" then SqlParser
      else
        raise ArgumentError, "Unsupported schema extension: #{extension}"
      end
    end

    attr_accessor :schema_path

    def initialize(schema_path)
      @schema_path = schema_path
    end

    def schema
      File.read(schema_path)
    end
  end
end
