# DatabaseSchemaOwnership

The project's main goal is to help you manage the ownership of the database schema in your Ruby application.
It has a one-line configuration and it will take care of the rest.
You can use the DSL to satisfy your custom needs for more complex scenarios.

## How it works?

GitHub Code Ownership provides an easy way to manage the code ownership per file.
This means that splitting the schema file into multiple files and assigning ownership to specific team members will help you control the schema.
Therefore, the only gem that Gem does is split the schema file into multiple files to assign ownership to the specific team members.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'database_consistency', group: :development, require: "database_schema_ownership/railtie"
```

That's it! The gem will automatically adjust the rake tasks for you. 
That means, every time you dump your schema, the gem will create the ownership files for you.

## Custom configuration

*Note:* In case you don't need automatically adjusted rake tasks, you can omit the require:

```ruby
gem 'database_consistency', group: :development
```

And simply run the following command to create the database ownership files:
```ruby
# schema_path - "db/schema.rb" or "db/structure.sql" or any other path
# folder_path - "db/database_schema_ownership" or any other path to store the ownership files
DatabaseSchemaOwnership::Runner.new(schema_path, folder_path).run
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/djezzzl/database_schema_ownership. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/djezzzl/database_schema_ownership/blob/master/CODE_OF_CONDUCT.md).

## License

Copyright (c) Evgeniy Demin. See [LICENSE.txt](https://github.com/djezzzl/database_schema_ownership/blob/master/LICENSE.txt) for further details.

## Code of Conduct

Everyone interacting in the DatabaseSchemaOwnership project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/djezzzl/database_schema_ownership/blob/master/CODE_OF_CONDUCT.md).
