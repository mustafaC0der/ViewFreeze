require_relative 'logging_service'

# Module for standardized error handling.
module ErrorHandler
  def self.handle_error(error)
    puts "Error: #{error.message}"
    LoggingService.log_error(error.message)
  end

  def self.handle_critical_error(error)
    puts "Critical Error: #{error.message}"
    LoggingService.log_error("CRITICAL: #{error.message}")
    puts "Terminating application."
    exit(1)
  end
end
