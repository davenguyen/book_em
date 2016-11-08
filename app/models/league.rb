class League < Sequel::Model
  many_to_one :sport

  one_to_many :teams
end
