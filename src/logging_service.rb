# logging_service.rb

# Module for centralized logging.
module LoggingService
    LOG_FILE = "app.log"
  
    def self.log_info(message)
      log("INFO", message)
    end
  
    def self.log_error(message)
      log("ERROR", message)
    end
  
    private
  
    def self.log(level, message)
      File.open(LOG_FILE, "a") do |file|
        file.puts("#{Time.now} [#{level}] - #{message}")
      end
    end
  end
  