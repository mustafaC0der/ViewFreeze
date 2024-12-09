# search_service.rb
require 'pdf-reader'

# Class to handle text searching within PDFs.
class SearchService
  def initialize(file_path)
    @file_path = file_path
    validate_file
    @reader = PDF::Reader.new(@file_path)
  end

  def search(query)
    results = []
    @reader.pages.each_with_index do |page, index|
      text = page.text
      results << { page: index + 1, content: text } if text.include?(query)
    end
    results
  rescue StandardError => e
    raise "Search failed: #{e.message}"
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
end
