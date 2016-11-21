# == Schema Info
#
# amount      :decimal   indexed      not null
# created_at  :datetime  indexed      not null
# id          :uuid      primary_key  not null, default(uuid_generate_v4())
# payout      :decimal   indexed
# type        :string    indexed      not null
# user_id     :uuid      indexed      not null
#

class Bet < Sequel::Model
  many_to_many :bet_odds
  many_to_one  :user

  dataset_module do
    def awaiting
      where(payout: nil)
    end

    def losers
      where(payout: 0)
    end

    def winners
      where{payout > 0}
    end
  end

  def estimated_payout
    amount * (odds_factor - 1)
  end

  def odds_factor
    bet_odds.map(&:payout_factor).inject(:*)
  end

  def won?
    payout && payout > 0
  end
end
