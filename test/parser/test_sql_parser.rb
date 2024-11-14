# frozen_string_literal: true

require "test_helper"

class TestRubyParser < Minitest::Test
  def schema_path
    "test/parser/schema.sql"
  end

  def expected_entities # rubocop:disable Metrics/MethodLength
    [
      DatabaseSchemaOwnership::Entity.new("users", <<~SCHEMA
        CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
      SCHEMA
      ),
      DatabaseSchemaOwnership::Entity.new("locations", <<~SCHEMA
        CREATE TABLE IF NOT EXISTS "locations" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_5e107925c6"
            FOREIGN KEY ("user_id")
            REFERENCES "users" ("id")
        );
      SCHEMA
      ),
      DatabaseSchemaOwnership::Entity.new("locations", <<~SCHEMA
        CREATE INDEX "index_locations_on_user_id" ON "locations" ("user_id") /*application='Rails8Example'*/;
      SCHEMA
      )
    ]
  end

  def test_parse
    parsed_schema = DatabaseSchemaOwnership::Parser::SqlParser.new(schema_path).parse

    assert_equal expected_entities.map(&:name), parsed_schema.map(&:name)
    assert_equal expected_entities.map(&:metadata), parsed_schema.map(&:metadata)
  end
end
