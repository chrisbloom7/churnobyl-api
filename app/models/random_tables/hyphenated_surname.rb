# frozen_string_literal: true

module RandomTables
  class HyphenatedSurname
    # Number of times to try to get the selected number of unique surnames
    MAX_UNIQUE_ATTEMPTS = 3

    class << self
      # Generate a string of hyphenated surnames.
      #
      # max - max surnames; may select fewer. (default: 2, min: 1, max: 100)
      # weight - chance of > 1 surnames. (default: 0.25, min: 0, max: 1)
      # join - whether to return a string instead of an array. (default: true)
      # separator - the string to join the surnames on. (default: "-")
      #
      # Returns a string joined by `separator` by default. If `join` is false
      # then returns the array of selected surname instances instead. In either
      # case, only unique surnames will be included in the return value.
      def random(max: 2, weight: 0.25, join: true, separator: '-')
        raise ArgumentError, 'Invalid max (must be between 1 and 100)' if max < 1 || max > 100

        raise ArgumentError, 'Invalid weight (must be between 0.0 and 1)' if weight.negative? || weight > 1

        surnames = []
        count = weighted_random_count(max, weight)
        select_unique_surnames!(count, surnames)

        # We will try up to MAX_WEIGHT_ATTEMPTS times to get the max num names
        if surnames.size < count
          n = 1
          while surnames.size < count && n < MAX_UNIQUE_ATTEMPTS
            select_unique_surnames!(count - surnames.size, surnames)
            n += 1
          end
        end

        return surnames.join(separator) if join

        surnames
      end

      private

      def get_surname
        RandomTables::Surname.random
      end

      def select_unique_surnames!(count, surnames)
        count.times { surnames << get_surname }
        surnames.uniq!
      end

      # h/t https://gist.github.com/O-I/3e0654509dd8057b539a
      def weighted_random_count(max, weight)
        range = Range.new(1, max).to_a
        weights = [1 - weight] + Array.new(max - 1, weight)
        weighted_range = range.zip(weights).to_h
        weighted_range.max_by { |_, w| rand**(1.0 / w) }.first
      end
    end
  end
end
