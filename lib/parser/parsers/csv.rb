# frozen_string_literal: true

module Parsers
  class Csv < Base
    attr_reader :file_path, :separator

    def initialize(file_path, separator = ';')
      @file_path = file_path
      @separator = separator
    end

    def parse
      file_reader.drop(1).map do |line|
        split_line(line).zip(header_types).map { |value, type| type.new(value) }
      end
    end

    def headers
      @headers ||= split_line(file_reader.first)
    end

    private

    def header_types
      @header_types ||= headers.map do |header_type|
        class_name = header_type.split('_').map(&:capitalize).join
        Types.const_get(class_name)
      end
    rescue NameError => e
      raise Types::Unknown, e.message
    end

    def file_reader
      File.readlines(file_path)
    end

    def split_line(line)
      line.strip.split(separator, -1)
    end
  end
end
