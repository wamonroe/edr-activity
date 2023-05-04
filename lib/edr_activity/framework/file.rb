require "pathname"

require_relative "base"
require_relative "configuration"
require_relative "errors"

module EDRActivity
  module Framework
    class File < Base
      def initialize(path:, mode:, content: "")
        @path = Pathname.new(path)
        @mode = mode
        @content = content
      end

      def call
        case @mode
        when :create
          create_file
        when :update
          update_file
        when :delete
          delete_file
        else
          raise UnknownModeError, "unknown mode - #{@mode}"
        end
      end

      private

      def delete_file
        if @path.exist? && @path.file?
          ::File.delete(@path)
          log_activity
        elsif @path.exist? && @path.directory?
          raise PathMismatchError, "can't delete folder - #{@path}"
        else
          raise PathMissingError, "no such file - #{@path}"
        end
      end

      def create_file
        if @path.exist?
          raise PathExistsError, "file or folder already exists - #{@path}"
        else
          write_content
          log_activity
        end
      end

      def update_file
        if @path.exist? && @path.file?
          write_content
          log_activity
        elsif @path.exist? && @path.directory?
          raise PathMismatchError, "can't update contents on folder - #{@path}"
        else
          raise PathMissingError, "no such file - #{@path}"
        end
      end

      def log_activity
        EDRActivity::Framework.logger.info({
          activity: "file",
          file_path: @path.to_s,
          file_activity: @mode.to_s
        })
      end

      def write_content
        ::File.write(@path, @content)
      end
    end
  end
end
