require 'pty'

module Heroku::Command::Deploy::Helpers

  # Runs given command using a pseudo-terminal to allow streaming of output
  #
  # Any given block receives the buffered output and its return value is
  # evaluated as success (truthy) or failure (falsy). If no block is given,
  # the actual process exit status will be used.
  #
  # Options:
  #   :out (io, defaults to $stdout)
  #   :dry_run (whether to execute any commands, defaults to false)
  #
  def run(command, options = {}, &block)
    options = {
      out: $stdout,
      dry_run: false
    }.merge(@options).merge(options)

    buffer = StringIO.new

    if options[:dry_run]
      options[:out].puts(" $ #{command}")
    else
      PTY.spawn(command) do |output, input, pid|
        begin
          while !output.eof?
            chunk = output.readpartial(1024)
            buffer << chunk
            options[:out].print(chunk) if options[:out]
          end
        rescue Errno::EIO
        ensure
          Process.wait(pid)
        end
      end

      if !$?.success? || (block_given? && !block.call(buffer.string))
        raise Heroku::Command::Deploy::CommandExecutionFailure
      end
    end

    buffer.string
  end

  # Runs given Heroku command
  def heroku(command, options = {}, &block)
    run "heroku #{command} -a #{app}", options, &block
  end

  # Runs given command remotely on Heroku
  def heroku_run(command, options = {})

    # Parse exit status from output manually as it is not provided by Heroku
    # See: https://github.com/heroku/heroku/issues/186
    heroku "run '#{command}; echo \$?'", options do |output|
      output[/\d+\s*\Z/].to_i.zero?
    end

  end

end
