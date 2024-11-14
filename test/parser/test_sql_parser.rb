# frozen_string_literal: true

require "test_helper"

class TestSqlParser < Minitest::Test
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
      ),
      DatabaseSchemaOwnership::Entity.new("public.administrators", <<~SCHEMA
        CREATE TABLE public.administrators (
            id integer NOT NULL,
            name character varying NOT NULL,
            user_id integer
        );
      SCHEMA
      ),
      DatabaseSchemaOwnership::Entity.new("public.administrators", <<~SCHEMA
        CREATE INDEX administrators_name_index ON public.administrators USING btree (name);
      SCHEMA
      ),
      DatabaseSchemaOwnership::Entity.new("public.administrators", <<~SCHEMA
        CREATE UNIQUE INDEX administrators_name_index ON public.administrators USING btree (name);
      SCHEMA
      ),
      DatabaseSchemaOwnership::Entity.new("public.administrators", <<~SCHEMA
        ALTER TABLE ONLY public.administrators
            ADD CONSTRAINT fk_rails_12345 FOREIGN KEY (user_id) REFERENCES public.users(id);
      SCHEMA
      )
    ]
  end

  def test_parse
    parsed_schema = DatabaseSchemaOwnership::Parser::SqlParser.new(schema_path).parse

    expected_entities.each_with_index do |expected_entity, index|
      assert_equal(expected_entity.name, parsed_schema[index].name)
      assert_equal(expected_entity.metadata, parsed_schema[index].metadata)
    end
  end
end
