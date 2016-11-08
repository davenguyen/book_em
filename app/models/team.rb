class Team < Sequel::Model
  many_to_one :league
end
