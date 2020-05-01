module RandomTables
  class Surname < ApplicationYamlHash
    include RandomTable

    # Generate a string of hyphenated surnames.
    #
    # max - the maximum number of surnames to select; may select fewer. (default: 2)
    # join - whether to join the selected surnames with separator, or return an array. (default: true)
    # separator - the string to join the surnames on. (default: "-")
    #
    # Returns a string joined by `separator` by default. If `join` is false then returns
    # the array of selected surname instances instead. In either case, only unique
    # surnames will be included in the return value.
    def self.hyphenated(max: 2, join: true, separator: "-")
      surnames = []
      (rand(max)+1).times do
        surnames << self.random
      end
      surnames.uniq!
      return surnames.map(&:value).join(separator) if join
      surnames
    end
  end
end
