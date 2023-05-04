require "thor"
require "edr_activity/framework/file"

module EDRActivity
  module CLI
    class File < Thor
      desc "create PATH", "create file"
      option :content, required: true, desc: "content of file created"
      def create(path)
        EDRActivity::Framework::File.call(
          mode: :create,
          path: path,
          content: options[:content]
        )
      end

      desc "update PATH", "update file"
      option :content, required: true, desc: "content of file update"
      def update(path)
        EDRActivity::Framework::File.call(
          mode: :update,
          path: path,
          content: options[:content]
        )
      end

      desc "delete PATH", "delete file"
      def delete(path)
        EDRActivity::Framework::File.call(mode: :delete, path: path)
      end
    end
  end
end
