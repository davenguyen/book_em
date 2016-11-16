# == Schema Info
#
# abbreviation  :string  indexed
# city          :string  indexed      not null
# id            :uuid    primary_key  not null, default(uuid_generate_v4())
# league_id     :uuid    indexed
# mascot        :string  indexed      not null
#

class Team < Sequel::Model
  many_to_one :league

  class << self
    %w(over tied under).each do |field|
      f = field == 'tied' ? 'tie' : field
      define_method(field) { Team.first(name: f.capitalize) }
    end
  end
end
