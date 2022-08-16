
module Attitude
  # Social Encounters, page 103
  RULE = <<~DESC
    First impressions matter. The GM decides how an NPC feels about you based on that character’s motives and emotions. In other words, the GM sets the NPC’s attitude. The GM doesn’t need to use any rules, but might find it useful to select an attitude from the *Attitudes* table, or roll 3d6, adding the following modifiers:

    *COMMUNICATION* Add the Communication ability score of the character taking the lead in making contact. If a Communication focus would apply to the first impression, add its bonus as well.

    *REPUTATION* Add +2 for a Reputation that would impress the NPC. Impose -2 for a Reputation that would offend the NPC. See the Rewards chapter for more about Reputation.

    *OTHER MODIFIERS* The GM can add other modifiers to the roll based on the NPC’s known feelings and motives.

    One overriding rule is that NPCs will never defy their most deeply held values or sacrifice their personal safety without an exceptional circumstance coming into play. Violent threats using Strength (Intimidation) are one way to sway an unwilling NPC. Blackmail, lies, and other methods may work as well, but the NPC may resent you for this, with potential consequences in the future.
  DESC

  DESCRIPTION_VERY_HOSTILE = "The very hostile NPC can barely contain their dislike, and is inclined to respond to contact with either violence or by leaving the characters’ presence. They may nurse a grudge and oppose the characters in the future. This is a rare spontaneous impression, and the GM should come up with a specific reason why any first impression would get a Very Hostile response."

  DESCRIPTION_HOSTILE = "The hostile NPC reacts to contact with ire, but might disguise this. They either refuse to provide help, or undermine the characters’ apparent interests."

  DESCRIPTION_STANDOFFISH = "The standoffish NPC would prefer that the characters just leave them alone. They either avoid the characters, ignore them, or firmly ask interlopers to go away."

  DESCRIPTION_NEUTRAL = "The neutral NPC hasn’t decided things either way about characters making contact, and responds with cool caution, bored disinterest, or polite detachment, depending on their personality."

  DESCRIPTION_OPEN = "The open NPC is curious or inclined to listen to the characters, and reacts appropriately based on their own motives and interests. Things could go either way. A negative variation of Open is *Cowed*, where the NPC is a bit afraid of what the characters might do if they don’t act receptive. Once the threat appears to be gone, the NPC becomes Standoffish."

  DESCRIPTION_FRIENDLY = "The friendly NPC takes a shine to characters making contact and is inclined to help them, but hesitates to provide any assistance that could cause them problems. A negative variation of Friendly is *Shaken*, where the NPC provides assistance out of fear. Once the threat appears to be gone, the NPC becomes Hostile."

  DESCRIPTION_VERY_FRIENDLY = "The very friendly NPC is exceptionally welcoming, and provides gestures of respect or hospitality without being prompted. The NPC may provide extraordinary help, though nothing that contradicts their values. This is a rare spontaneous impression, and the GM should come up with a specific reason why any first impression would get a Very Friendly response. A negative variation of Very Friendly is *Terrified*, where the NPC anxiously does anything possible to avoid a perceived (or very real) threat. Once the threat is gone and the NPC feels safe, their attitude shifts to Very Hostile."

  ATTITUDE_VERY_HOSTILE =  { label: "Very Hostile",  modifier: "-3", description: DESCRIPTION_VERY_HOSTILE }
  ATTITUDE_HOSTILE =       { label: "Hostile",       modifier: "-2", description: DESCRIPTION_HOSTILE }
  ATTITUDE_STANDOFFISH =   { label: "Standoffish",   modifier: "-1", description: DESCRIPTION_STANDOFFISH }
  ATTITUDE_NEUTRAL =       { label: "Neutral",       modifier: "+0", description: DESCRIPTION_NEUTRAL }
  ATTITUDE_OPEN =          { label: "Open",          modifier: "+1", description: DESCRIPTION_OPEN }
  ATTITUDE_FRIENDLY =      { label: "Friendly",      modifier: "+2", description: DESCRIPTION_FRIENDLY }
  ATTITUDE_VERY_FRIENDLY = { label: "Very Friendly", modifier: "+3", description: DESCRIPTION_VERY_FRIENDLY }

  # TODO:
  # - subclass that includes way to select from a range in a TABLE, `h[h.keys.select { |r| r.cover?(2) }]`
  # - force check against range min/max, or detect if out of range and force to low/high value
  # - linter that checks that all ranges are exclusive
  # - maybe an array would be mor simple
  # - YAML instead of constants?
  TABLE = {
    3      => ATTITUDE_VERY_HOSTILE,
    4..5   => ATTITUDE_HOSTILE,
    6..8   => ATTITUDE_STANDOFFISH,
    9..11  => ATTITUDE_NEUTRAL,
    12..14 => ATTITUDE_OPEN,
    15..17 => ATTITUDE_FRIENDLY,
    18     => ATTITUDE_VERY_FRIENDLY
  }
end
