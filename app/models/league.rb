class League < Sequel::Model
  many_to_one :sport
end
