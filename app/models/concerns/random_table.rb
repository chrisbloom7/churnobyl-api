require 'active_support/concern'

module RandomTable
  extend ActiveSupport::Concern

  included do
  end

  class_methods do
    def random
      in_table_range d6, self::TABLE
    end

    def d6
      rand(6) + 1
    end

    def in_table_range(result, table)
      table[
        table.keys.detect do |range|
          if range.is_a?(Range)
            range.cover?(result)
          elsif range.is_a?(Array)
            range.include?(result)
          else
            range == result
          end
        end
      ]
    end
  end
end
