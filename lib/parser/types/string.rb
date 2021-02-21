# frozen_string_literal: true

module Types
  class String
    def initialize(value, separator = ' ')
      @value = value.strip
      @separator = separator
    end

    def to_s
      value.split(@separator).join("\n")
    end

    def value
      @value
    end

    def align_side
      :left
    end
  end
end
