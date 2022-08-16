module AttackRollModifiers
  TABLE = [
    %w[MODIFIER CIRCUMSTANCE],
    ["–5", "Attacker is blind or otherwise completely unable to see the target."],
    ["–3", "Defender in heavy cover, such as a building or stone wall. Melee attacker in heavy snow."],
    ["–2", "Defender in light cover, such as a hedge or the woods. Melee attacker in the mud. Ranged attack vs. defender engaged in melee combat. Combat at night."],
    ["–1", "Rain, mist, or smoke obscures the defender. Combat in low light conditions."],
    ["0", "Normal circumstances."],
    ["+1", "Attacker is on higher ground. Defender is prone. Melee attacker and allies outnumber defender 2 to 1."],
    ["+2", "Melee attacker and allies outnumber defender 3 to 1. Defender is drunk."],
    ["+3", "Defender is unaware of the attack."],
  ]
end
