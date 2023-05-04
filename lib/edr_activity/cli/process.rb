require "thor"
require "edr_activity/framework/process"

module EDRActivity
  module CLI
    class Process < Thor
      desc "start PROCESS ...ARGS", "start process"
      def start(process, *args)
        EDRActivity::Framework::Process.call(
          process: process,
          args: args
        )
      end
    end
  end
end
