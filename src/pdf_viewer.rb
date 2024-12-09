# pdf_viewer.rb
require_relative 'pdf_reader'
require_relative 'pdf_utils'

class PDFViewer
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
    validate_file
    @reader = PDFReader.new(@file_path)
  end

  def display_pdf
    puts "\n--- PDF Content ---"
    @reader.read.each_with_index do |page, index|
      puts "\nPage #{index + 1}:"
      puts page
      puts "-" * 50
    end
  rescue StandardError => e
    puts "Error displaying PDF: #{e.message}"
    log_error(e)
  end

  private

  def validate_file
    unless File.exist?(@file_path)
      raise "File not found: #{@file_path}"
    end

    unless File.extname(@file_path) == ".pdf"
      raise "Invalid file type. Only PDF files are supported."
    end
  end

  def log_error(error)
    File.open("viewer_error.log", "a") do |file|
      file.puts("#{Time.now} - Viewer Error: #{error.message}")
      file.puts(error.backtrace)
    end
  end
end
