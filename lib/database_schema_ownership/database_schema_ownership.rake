# frozen_string_literal: true

namespace :database_schema_ownership do
  desc "Generate ownership files for database schema"
  task dump: "db:schema:dump" do
    DatabaseSchemaOwnership::Runner.new.run
  end
end

Rake::Task["db:schema:dump"].enhance do
  Rake::Task["database_schema_ownership:dump"].invoke
end
