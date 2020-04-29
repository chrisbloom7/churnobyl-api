class NPCSerializer
  include FastJsonapi::ObjectSerializer
  set_type :npc
  set_id :id
  attributes :age, :ancestry, :attitude, :gender, :origin
end
