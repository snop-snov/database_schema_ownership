# frozen_string_literal: true

module DatabaseSchemaOwnership
  class Entity # :nodoc:
    attr_reader :name, :metadata

    def initialize(name, metadata)
      @name = name
      @metadata = metadata
    end
  end
end
