# API Documentation for ViewFreeze

## Overview
The ViewFreeze application provides functionalities for viewing, reading, and interacting with PDF files. This document describes the available modules, their classes, and public methods.

---

## Modules and Classes

### 1. **PDFViewer**
**File**: `src/pdf_viewer.rb`

**Purpose**: Handles displaying PDF content to the user.

#### Public Methods
- `initialize(file_path)`
  - **Description**: Initializes the viewer with the specified PDF file.
  - **Parameters**:
    - `file_path`: Path to the PDF file.
- `display_pdf`
  - **Description**: Reads and displays the content of the PDF file.

---

### 2. **PDFReader**
**File**: `src/pdf_reader.rb`

**Purpose**: Handles low-level reading and validation of PDF files.

#### Public Methods
- `initialize(file_path)`
  - **Description**: Initializes the reader with the PDF file.
  - **Parameters**:
    - `file_path`: Path to the PDF file.
- `read`
  - **Description**: Extracts text content from all pages of the PDF.
  - **Returns**: Array of strings, where each string represents the content of one page.

---

### 3. **PDFMetadata**
**File**: `src/pdf_metadata.rb`

**Purpose**: Extracts metadata from PDF files.

#### Public Methods
- `self.extract(file_path)`
  - **Description**: Extracts metadata such as title, author, and creation date.
  - **Parameters**:
    - `file_path`: Path to the PDF file.
  - **Returns**: Hash containing metadata keys and values.

---

### 4. **SearchService**
**File**: `src/search_service.rb`

**Purpose**: Provides text search functionality within PDF files.

#### Public Methods
- `initialize(file_path)`
  - **Description**: Prepares the PDF file for searching.
  - **Parameters**:
    - `file_path`: Path to the PDF file.
- `search(query)`
  - **Description**: Searches for a specific text in the PDF.
  - **Parameters**:
    - `query`: Text to search for.
  - **Returns**: Array of hashes with page numbers and matching content.

---

### 5. **LoggingService**
**File**: `src/logging_service.rb`

**Purpose**: Centralized logging for the application.

#### Public Methods
- `self.log_info(message)`
  - **Description**: Logs an informational message.
- `self.log_error(message)`
  - **Description**: Logs an error message.

---

### 6. **ErrorHandler**
**File**: `src/error_handler.rb`

**Purpose**: Provides standardized error handling.

#### Public Methods
- `self.handle_error(error)`
  - **Description**: Handles non-critical errors.
- `self.handle_critical_error(error)`
  - **Description**: Handles critical errors and terminates the application.
