# frozen_string_literal: true

module Rollers
  module Challenge
    extend self

    def drama
      [[d6, d6], d6]
    end

    def roll
      drama.flatten.sort
    end

    def simple
      roll.sum
    end

    def drop
      (roll + [d6]).sort[1..3]
    end

    private

    def d6
      rand(1..6)
    end
  end
end
