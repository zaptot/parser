# frozen_string_literal: true

module Exporters
  class Base
    def self.export(data)
      raise NotImplementedError
    end
  end
end
