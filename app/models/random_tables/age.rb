module RandomTables
  class Age
    include RandomTable

    TABLE = {
      1 => "a child",
      2 => "a teenager",
      3 => "a young adult",
      4 => "a middle age adult",
      5 => "an older adult",
      6 => "elderly",
    }
  end
end
