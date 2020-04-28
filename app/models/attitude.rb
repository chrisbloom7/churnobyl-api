
class Attitude
  include RandomTable

  TABLE = {
    3      => "Very Hostile",
    4..5   => "Hostile",
    6..8   => "Standoffish",
    9..11  => "Neutral",
    12..14 => "Open",
    15..17 => "Friendly",
    18     => "Very Friendly",
  }

  def self.random
    in_table_range(d6 + d6 + d6, TABLE)
  end
end
