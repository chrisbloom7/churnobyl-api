class NPCSerializer
  include FastJsonapi::ObjectSerializer
  set_type :npc
  set_id :id
  attributes :age, :attitude, :ethnicity, :gender, :origin
end
