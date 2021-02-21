# frozen_string_literal: true

module Types
  class Int
    def initialize(value)
      @value = value.to_i
    end

    def to_s
      value.to_s
    end

    def value
      @value
    end

    def align_side
      :right
    end
  end
end
