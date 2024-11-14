# frozen_string_literal: true

require "test_helper"

class TestRubyParser < Minitest::Test
  def schema_path
    "test/parser/schema.rb"
  end

  def expected_entities # rubocop:disable Metrics/MethodLength
    [
      DatabaseSchemaOwnership::Entity.new("locations", <<SCHEMA
  create_table "locations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_locations_on_user_id"
  end
SCHEMA
      ),
      DatabaseSchemaOwnership::Entity.new("users", <<SCHEMA
  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
SCHEMA
      ),
      DatabaseSchemaOwnership::Entity.new("locations", <<SCHEMA
  add_foreign_key "locations", "users"
SCHEMA
      )
    ]
  end

  def test_parse
    parsed_schema = DatabaseSchemaOwnership::Parser::RubyParser.new(schema_path).parse

    assert_equal expected_entities.map(&:name), parsed_schema.map(&:name)
    assert_equal expected_entities.map(&:metadata), parsed_schema.map(&:metadata)
  end
end
