# frozen_string_literal: true

module Types
  class Unknown < StandardError; end

  class Base
    def value
      raise NotImplementedError
    end

    def to_s
      raise NotImplementedError
    end

    def align_side
      raise NotImplementedError
    end
  end
end
