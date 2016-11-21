# == Schema Info
#
# created_at              :datetime  indexed      not null
# email                   :string    indexed      not null
# id                      :uuid      primary_key  not null, default(uuid_generate_v4())
# name                    :string                 not null
# oauth_token             :string                 not null
# oauth_token_expires_at  :datetime
# profile_image_url       :string                 not null
# provider                :string    indexed      not null
# uid                     :string    indexed      not null
# updated_at              :datetime  indexed      not null
#

class User < Sequel::Model
  one_to_many :bets
end
