# == Schema Info
#
# id    :uuid    primary_key  not null, default(uuid_generate_v4())
# name  :string  indexed      not null
#

class Sport < Sequel::Model
  one_to_many :leagues
end
