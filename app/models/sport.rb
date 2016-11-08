class Sport < Sequel::Model
  one_to_many :leagues
end
