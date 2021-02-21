# frozen_string_literal: true

module Exporters
  class Console
    def self.export(data)
      puts data.to_s
    end
  end
end
