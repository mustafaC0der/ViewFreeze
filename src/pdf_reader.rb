# pdf_reader.rb
require 'pdf-reader'

class PDFReader
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
    validate_file
  end

  def read
    reader = PDF::Reader.new(@file_path)
    pages = reader.pages.map(&:text)
    log_pages_read(pages)
    pages
  rescue PDF::Reader::MalformedPDFError => e
    raise "Malformed PDF: #{e.message}"
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

  def log_pages_read(pages)
    File.open("reader_log.log", "a") do |file|
      file.puts("#{Time.now} - Read #{pages.size} pages from #{@file_path}")
    end
  end
end
