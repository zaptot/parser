# frozen_string_literal: true

module ExportStructures
  class Table
    attr_reader :rows

    INTERSECTION_SYMBOL = '+'
    HORIZONTAL_SYMBOL = '-'
    VERTICAL_SYMBOL = '|'

    def initialize(rows)
      @rows = rows
    end

    def to_s
      string_rows = rows.each_with_object([]) do |row, string_rows|
        string_rows << map_row_line(row) do |row_line|
          [VERTICAL_SYMBOL, row_line.join(VERTICAL_SYMBOL), VERTICAL_SYMBOL].join
        end.join("\n")
      end.join(row_divider)
      [row_divider, string_rows, row_divider].join.strip
    end

    private

    def map_row_line(row)
      row_height(row).times.with_object([]) do |line_number, row_lines|
        row_line = row.map.with_index do |column, column_id|
          line_value = column.to_s.split("\n")[line_number]&.strip || ''
          add_aligment(line_value, column_id, column.align_side)
        end

        row_lines << yield(row_line)
      end
    end

    def add_aligment(line_value, column_id, alignment)
      column_addition_size = columns_sizes[column_id] - line_value.size
      case alignment
      when :left
        [line_value, (' ' * column_addition_size)].join
      when :right
        [(' ' * column_addition_size), line_value].join
      else
        raise UnknownAlignType
      end
    end

    def row_divider
      @row_divider ||= columns_sizes.map { |columns_size| HORIZONTAL_SYMBOL * columns_size }
                                    .join(INTERSECTION_SYMBOL)
                                    .then { |row| ["\n", INTERSECTION_SYMBOL, row, INTERSECTION_SYMBOL, "\n"].join }
    end

    def columns_sizes
      @columns_sizes ||= rows.each_with_object(Array.new(columns_count, 0)) do |row, max_columns|
        row.each_with_index do |column, index|
          column_size = column.to_s.size
          max_columns[index] = column_size if column_size > max_columns[index]
        end
      end
    end

    def row_height(row)
      row.map { |column| column.to_s.split("\n").size }.max
    end

    def columns_count
      @columns_count ||= rows.first&.size
    end
  end
end
