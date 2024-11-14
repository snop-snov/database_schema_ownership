CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "locations" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_5e107925c6"
    FOREIGN KEY ("user_id")
    REFERENCES "users" ("id")
);
CREATE INDEX "index_locations_on_user_id" ON "locations" ("user_id") /*application='Rails8Example'*/;
INSERT INTO "schema_migrations" (version) VALUES ('20241112133340'), ('20241112133327');

