# frozen_string_literal: true

module ExportStructures
  class UnknownAlignType < StandardError; end

  class Base
    def to_s
      raise NotImplementedError
    end
  end
end
