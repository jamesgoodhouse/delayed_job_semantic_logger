SemanticLogger.appenders.first.filter = Proc.new { |log| log.name != 'Delayed' }

SemanticLogger.appenders.first.formatter = Proc.new do |log|
  colors      = SemanticLogger::AnsiColors
  level_color = colors::LEVEL_MAP[log.level]

  # Header with date, time, log level and process info
  message     = "#{log.formatted_time} #{level_color}#{log.level_to_s}#{colors::CLEAR} [#{log.process_info}]"

  # Tags
  message << ' ' << log.tags.collect { |tag| "[#{level_color}#{tag}#{colors::CLEAR}]" }.join(' ') if log.tags && (log.tags.size > 0)

  # Duration
  message << " (#{colors::BOLD}#{log.duration_human}#{colors::CLEAR})" if log.duration

  # Class / app name
  message << " #{level_color}#{log.name}#{colors::CLEAR}"

  # Log message
  message << " -- #{log.message}" if log.message

  # Payload: Colorize the payload if the AwesomePrint gem is loaded
  if log.has_payload?
    payload = log.payload
    message << ' -- ' <<
      if !defined?(AwesomePrint) || !payload.respond_to?(:ai)
        payload.inspect
      else
        payload.ai(@ai_options) rescue payload.inspect
      end
  end

  # Exceptions
  if log.exception
    message << " -- Exception: #{colors::BOLD}#{log.exception.class}: #{log.exception.message}#{colors::CLEAR}\n"
    message << log.backtrace_to_s
  end
  message
end
