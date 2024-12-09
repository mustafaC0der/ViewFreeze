# pdf_utils.rb
require 'prawn'

module PDFUtils
  def self.generate_sample_pdf(file_path)
    Prawn::Document.generate(file_path) do
      text "Welcome to ViewFreeze PDF Viewer!", size: 20, style: :bold
      text "\nThis is a sample PDF document created using the Prawn gem."
      text "\nEnjoy using ViewFreeze!", align: :center
      3.times do |i|
        start_new_page
        text "Page #{i + 2}: More Content", size: 16
        text "This is additional content for page #{i + 2}."
      end
    end
  rescue StandardError => e
    puts "Error generating sample PDF: #{e.message}"
    log_error(e)
  end

  def self.log_error(error)
    File.open("utils_error.log", "a") do |file|
      file.puts("#{Time.now} - Utils Error: #{error.message}")
      file.puts(error.backtrace)
    end
  end
end
