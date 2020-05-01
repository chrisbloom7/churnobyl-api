module RandomTables
  class Ancestry < ApplicationYamlHash
    include RandomTable

    # Generate a string of random mixed ancestries.
    #
    # max - the maximum number of ancestries to select; may select fewer. (default: 2)
    # join - whether to join the selected ancestries with separator, or return an array. (default: true)
    # separator - the string to join the ancestries on. (default: "/")
    #
    # Returns a string joined by `separator` by default. If `join` is false then returns
    # the array of selected ancestry instances instead. In either case, only unique
    # ancestries will be included in the return value.
    def self.mixed(max: 2, join: true, separator: "/")
      ancestries = []
      (rand(max)+1).times do
        ancestries << self.random
      end
      ancestries.uniq!
      return ancestries.map(&:value).join(separator) if join
      ancestries
    end
  end
end
