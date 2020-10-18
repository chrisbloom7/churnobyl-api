module RandomTables
  class HyphenatedSurname
    # Number of times to try to get max unique names
    MAX_WEIGHT_ATTEMPTS = 100

    # Generate a string of hyphenated surnames.
    #
    # max - the max number of surnames to select; may select fewer. (default: 2)
    # weight - change of hyphenation, between 0 and 1 (default: 0.25)
    # join - whether to return a string instead of an array. (default: true)
    # separator - the string to join the surnames on. (default: "-")
    #
    # Returns a string joined by `separator` by default. If `join` is false
    # then returns the array of selected surname instances instead. In either
    # case, only unique surnames will be included in the return value.
    def self.random(max: 2, weight: 0.25, join: true, separator: "-")
      if max < 1 || max > 100
        raise ArgumentError, "Invalid max (must be between 1 and 100)"
      end

      if weight < 0.0 || weight > 1
        raise ArgumentError, "Invalid weight (must be between 0.0 and 1)"
      end

      surnames = []
      count = weighted_random_count(max, weight)
      count.times { surnames << get_surname }
      surnames.uniq!

      # We will try up to MAX_WEIGHT_ATTEMPTS times to get the max num names
      if surnames.size < count
        n = count
        while surnames.size < count && n < MAX_WEIGHT_ATTEMPTS
          surname = get_surname
          surnames << surname unless surnames.include?(surname)
          n += 1
        end
      end

      return surnames.join(separator) if join
      surnames
    end

    private

    def self.get_surname
      RandomTables::Surname.random
    end

    # h/t https://gist.github.com/O-I/3e0654509dd8057b539a
    def self.weighted_random_count(max, weight)
      range = Range.new(1, max).to_a
      weights = [1 - weight] + Array.new(max - 1, weight)
      weighted_range = range.zip(weights).to_h
      weighted_range.max_by { |_, weight| rand ** (1.0 / weight) }.first
    end
  end
end
