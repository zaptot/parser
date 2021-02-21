# frozen_string_literal: true

module Parsers
  class Base
    def parse
      raise NotImplementedError
    end

    def headers
      raise NotImplementedError
    end
  end
end
