require "thor"
require "logger"
require "pathname"

require_relative "file"
require_relative "network"
require_relative "process"

module EDRActivity
  module CLI
    class Core < Thor
      desc "file", "generate file activity"
      subcommand "file", File

      desc "network", "generate network activity"
      subcommand "network", Network

      desc "process", "generate process activity"
      subcommand "process", Process
    end
  end
end
