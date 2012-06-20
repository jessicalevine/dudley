module Dudley
  # The main Logger instance.
  def self.log
    @@log ||= self.default_logger
  end

  # Setter method for the log member.
  def self.log= new_log
    @@log = new_log
  end

  # The default logger instance. This method  exists simply to create the logger
  # with the  custom logging  formatting and colouring. It has  no state.  A new
  # instance is created every  time you call this method. Use  the log method to
  # actually log things.
  def self.default_logger
    logfile = Config[:logfile]
    logfile = STDOUT if logfile =~ /\Astdout\z/i
    logfile = STDERR if logfile =~ /\Astderr\z/i

    logger = Logger.new(logfile)
    logger.level = Config[:debug] ? Logger::DEBUG : Logger::INFO

    logger.formatter = proc do |severity, datetime, progname, msg|
      result = "[#{severity.ljust(5)} #{datetime}]: #{msg}\n"

      # Only set the colour if the logger is going to stdout.  We don't want
      # colour information in log files.
      if Config[:logfile] =~ /\Astdout\z/i
        case severity
        when "DEBUG"
          result.blue
        when "WARN"
          result.yellow
        when "ERROR"
          result.red
        else
          result.white
        end
      else
        result
      end
    end

    return logger
  end
end
