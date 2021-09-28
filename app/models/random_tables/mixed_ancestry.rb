# frozen_string_literal: true

module RandomTables
  class MixedAncestry
    # Number of times to try to get the selected number of unique ancestries
    MAX_UNIQUE_ATTEMPTS = 3

    class << self
      # Generate a string of random mixed ancestries.
      #
      # max - max ancestries; may select fewer. (default: 2, min: 1, max: 100)
      # weight - chance of > 1 ancestries. (default: 0.5, min: 0, max: 1)
      # join - whether to return a string instead of an array. (default: true)
      # separator - the string to join the ancestries on. (default: "/")
      #
      # Returns a string joined by `separator` by default. If `join` is false
      # then returns the array of selected ancestry instances instead. In either
      # case, only unique ancestries will be included in the return value.
      def random(max: 2, weight: 0.5, join: true, separator: '/')
        raise ArgumentError, 'Invalid max (must be between 1 and 100)' if max < 1 || max > 100

        raise ArgumentError, 'Invalid weight (must be between 0.0 and 1)' if weight < 0.0 || weight > 1

        ancestries = []
        count = weighted_random_count(max, weight)
        select_unique_ancestries!(count, ancestries)

        # We will try up to MAX_WEIGHT_ATTEMPTS times to get the max num of names
        if ancestries.size < count
          n = 1
          while ancestries.size < count && n < MAX_UNIQUE_ATTEMPTS
            select_unique_ancestries!(count - ancestries.size, ancestries)
            n += 1
          end
        end

        return ancestries.join(separator) if join

        ancestries
      end

      private

      def ancestry
        RandomTables::Ancestry.random
      end

      def select_unique_ancestries!(count, ancestries)
        count.times { ancestries << ancestry }
        ancestries.uniq!
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
