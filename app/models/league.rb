# == Schema Info
#
# abbreviation  :string  indexed      not null
# id            :uuid    primary_key  not null, default(uuid_generate_v4())
# name          :string  indexed      not null
# sport_id      :uuid    indexed      not null
#

class League < Sequel::Model
  many_to_one :sport

  one_to_many :teams
end
