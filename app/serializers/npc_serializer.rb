class NPCSerializer
  include FastJsonapi::ObjectSerializer
  attributes :age, :ancestry, :attitude, :first_name, :gender, :origin, :surname
end
