/* ActiveRecord 8 */
CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "locations" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_5e107925c6"
    FOREIGN KEY ("user_id")
    REFERENCES "users" ("id")
);
CREATE INDEX "index_locations_on_user_id" ON "locations" ("user_id") /*application='Rails8Example'*/;
INSERT INTO "schema_migrations" (version) VALUES ('20241112133340'), ('20241112133327');

/* early versions */
CREATE TABLE public.administrators (
    id integer NOT NULL,
    name character varying NOT NULL,
    user_id integer
);
CREATE INDEX administrators_name_index ON public.administrators USING btree (name);
CREATE UNIQUE INDEX administrators_name_index ON public.administrators USING btree (name);
ALTER TABLE ONLY public.administrators
    ADD CONSTRAINT fk_rails_12345 FOREIGN KEY (user_id) REFERENCES public.users(id);
