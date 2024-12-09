# main.rb
require_relative 'pdf_viewer'
require_relative 'pdf_utils'
require_relative 'search_service'
require_relative 'logging_service'
require_relative 'error_handler'

# Main class for the ViewFreeze application.
class ViewFreezeApp
  attr_reader :pdf_file

  def initialize
    @pdf_file = nil
    @viewer = nil
    @search_service = nil
    LoggingService.log_info("ViewFreeze Application started.")
  end

  def start
    puts_banner
    menu
  rescue StandardError => e
    ErrorHandler.handle_critical_error(e)
  end

  private

  def puts_banner
    puts "\n" + "=" * 50
    puts "Welcome to ViewFreeze - PDF Viewer".center(50)
    puts "=" * 50 + "\n"
  end

  def menu
    loop do
      puts "\nMain Menu:"
      puts "1. Open a PDF File"
      puts "2. Generate Sample PDF"
      puts "3. Extract Metadata"
      puts "4. Search Text in PDF"
      puts "5. Exit"
      print "Enter your choice: "
      choice = gets.chomp.to_i

      case choice
      when 1 then open_pdf
      when 2 then generate_sample_pdf
      when 3 then extract_metadata
      when 4 then search_text
      when 5 then exit_app
      else puts "Invalid choice. Please select 1-5."
      end
    end
  end

  def open_pdf
    print "Enter the path to the PDF file: "
    @pdf_file = gets.chomp
    @viewer = PDFViewer.new(@pdf_file)
    @viewer.display_pdf
  rescue StandardError => e
    ErrorHandler.handle_error(e)
  end

  def generate_sample_pdf
    print "Enter the name for the sample PDF file (default: sample.pdf): "
    file_name = gets.chomp
    file_name = "sample.pdf" if file_name.strip.empty?
    PDFUtils.generate_sample_pdf(file_name)
    puts "Sample PDF generated: #{file_name}"
  rescue StandardError => e
    ErrorHandler.handle_error(e)
  end

  def extract_metadata
    if @pdf_file.nil?
      puts "No PDF file is loaded. Please open a PDF file first."
      return
    end

    metadata = PDFMetadata.extract(@pdf_file)
    puts "\n--- PDF Metadata ---"
    metadata.each { |key, value| puts "#{key}: #{value}" }
  rescue StandardError => e
    ErrorHandler.handle_error(e)
  end

  def search_text
    if @pdf_file.nil?
      puts "No PDF file is loaded. Please open a PDF file first."
      return
    end

    print "Enter the text to search for: "
    query = gets.chomp
    @search_service ||= SearchService.new(@pdf_file)
    results = @search_service.search(query)
    puts "\n--- Search Results ---"
    results.each_with_index { |res, idx| puts "Page #{idx + 1}: #{res}" }
  rescue StandardError => e
    ErrorHandler.handle_error(e)
  end

  def exit_app
    puts "\nThank you for using ViewFreeze. Goodbye!"
    LoggingService.log_info("ViewFreeze Application closed.")
    exit
  end
end

if __FILE__ == $0
  app = ViewFreezeApp.new
  app.start
end
