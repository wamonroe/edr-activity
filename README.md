# EDRActivity

[![Test](https://github.com/wamonroe/edr-activity/actions/workflows/test.yml/badge.svg)](https://github.com/wamonroe/edr-activity/actions/workflows/test.yml)

> **Note**: This is gem was created as part of a coding exercise and is not
> meant to be used outside of the excerise it was created for. This gem has not
> been published to RubyGems.

This framework allows us to generate endpoint activity to test an EDR agent to
ensure that it is generating the appropriate telemtry. It facilities a number of
acitivies, including:

- Starting a process
- Creating a file
- Modifying a file
- Deleting a file
- Establishing a network connection and transmit data

This gem consitutes a framework and a simple CLI implementation.

## Table of Contents

- [EDRActivity](#edractivity)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Configuration](#configuration)
  - [Usage](#usage)
  - [CLI Usage](#cli-usage)
  - [Development](#development)
  - [Contributing](#contributing)
  - [License](#license)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "edr-activity"
```

And then execute:

```sh
bundle install
```

## Configuration

This framework logs the activities it generates by default to a
`logs/edr-activity.log`. To customize this behavior, create a `Logger` pointing
to the output location desired:

```ruby
EDRActivity::Framework.configure do |config|
  config.logger = Logger.new("logs/mylog.log")
end
```

For additional information and options avabile to `Logger`, see
https://www.rubydoc.info/gems/logger/Logger.

## Usage

### Process Activity

Start a process

```ruby
EDRActivity::Framework::Process.call(process: "ls")
```

Start a process, passing parameters

```ruby
EDRActivity::Framework::Process.call(process: "ls", args: ["-la", ".."])
```

### File Activity

Create a file with content

```ruby
EDRActivity::Framework::File.call(mode: :create, path: "example.txt", content: "hello")
```

Update a file with content

```ruby
EDRActivity::Framework::File.call(mode: :update, path: "example.txt", content: "hello")
```

Delete a file

```ruby
EDRActivity::Framework::File.call(mode: :delete, path: "example.txt")
```

### Network Activity

Generate TCP network activity

```ruby
EDRActivity::Framework::Network.call(protocol: :tcp, host: "example.com", port: 80, message: "hello")
```

Generate UDP network activity

```ruby
EDRActivity::Framework::Network.call(protocol: :udp, host: "dns.example.com", port: 53, message: "hello")
```

## CLI Usage

> **Note**: The example CLI included with this gem logs to a file named `edr-activity.log` in your home directory.

### Process Activity

Start a process

```shell
edr-activity process start ls
```

Start a process, passing parameters

```shell
edr-activity process start ls -la ..
```

### File Activity

Create a file with content

```shell
edr-activity file create example.txt --content=hello
```

Update a file with content

```shell
edr-activity file update example.txt --content="hello again"
```

Delete a file

```shell
edr-activity file delete example.txt
```

### Network Activity

Generate TCP network activity

```shell
edr-activity network tcp example.com 80 --message=hello
```

Generate UDP network activity

```shell
edr-activity network udp dns.example.com 53 --message=hello
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/rspec` to run the tests. You can also run:

- `bin/console` for an interactive prompt that will allow you to experiment
- `bin/rubocop` to run RuboCop to check the code style and formatting

To build this gem on your local machine, run `bundle exec rake build`. To
install the gem locally, run `gem install --local
pkg/edr-activity-<version>.gem`.To release a new version, update the version
number in `version.rb`, and then run `bundle exec rake release`, which will
create a git tag for the version, push git commits and the created tag, and push
the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/wamonroe/edr_activity.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
