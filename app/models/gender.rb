class Gender
  include RandomTable

  TABLE = {
    1..2 => "male",
    3..5 => "female",
    6 => "gender-fluid or agender",
  }
end
