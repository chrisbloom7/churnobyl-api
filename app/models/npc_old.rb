class NPCOld
  attr_reader :age, :attitude, :ethnicity, :gender, :origin

  def initialize
    @gender = in_table_range d6, Gender::TABLE
    @age = in_table_range d6, Age::TABLE
    @origin = in_table_range d6, Origin::TABLE

    ethinicities = []
    (rand(3)+1).times do
      ethnicity = in_table_range d6, EthnicFeature::TABLE
      if (choices = ethnicity.split("/")).any?
        ethnicity = choices.sample
      end
      ethinicities << ethnicity
    end
    @ethnicity = ethinicities.join("/")

    @attitude = in_table_range(d6 + d6 + d6, Attitude::TABLE)[:label]
  end

  private

  def d6(times = 1)
    rand(6) + 1
  end

  def in_table_range(result, table)
    table[
      table.keys.detect do |range|
        if range.is_a?(Range)
          range.cover?(result)
        elsif range.is_a?(Array)
          range.include?(result)
        else
          range == result
        end
      end
    ]
  end
end
