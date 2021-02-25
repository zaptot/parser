# frozen_string_literal: true

module Types
  class Money
    attr_reader :precision

    def initialize(value, precision = 2)
      @value = value.to_s.strip.to_f.round(precision)
      @precision = precision
    end

    def to_s
      integer_part, fractional_part = ("%.#{precision}f" % value).split('.')
      integer_part = integer_part.reverse.gsub(/(\d{3}(?=(\d)))/, "\\1 ").reverse

      [integer_part, fractional_part].compact.join(',')
    end

    def value
      @value
    end

    def align_side
      :right
    end
  end
end
