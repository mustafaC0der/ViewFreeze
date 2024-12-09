# pdf_metadata.rb
require 'pdf-reader'

# Class to extract metadata from PDF files.
class PDFMetadata
  def self.extract(file_path)
    validate_file(file_path)

    reader = PDF::Reader.new(file_path)
    metadata = reader.info
    metadata.merge({
      "Number of Pages" => reader.page_count,
      "File Path" => file_path
    })
  rescue StandardError => e
    raise "Failed to extract metadata: #{e.message}"
  end

  def self.validate_file(file_path)
    unless File.exist?(file_path)
      raise "File not found: #{file_path}"
    end

    unless File.extname(file_path) == ".pdf"
      raise "Invalid file type. Only PDF files are supported."
    end
  end
end
