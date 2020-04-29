module RandomTables
  class Origin
    include RandomTable

    HEADINGS = %w[1D6 RESULT].freeze
    TABLE = {
      1 => "Earther",
      2..3 => "Martian",
      4..6 => "Belter",
    }
  end
end
