class Team < Sequel::Model
  many_to_one :league

  class << self
    %w(over tied under).each do |field|
      f = field == 'tied' ? 'tie' : field
      define_method(field) { Team.first(name: f.capitalize) }
    end
  end
end
