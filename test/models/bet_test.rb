require 'test_helper'

class BetTest < ActiveSupport::TestCase
  test 'Estimated payout for favorite' do
    bet = fixture(:bet__straight_favorite)
    bet.add_bet_odd(favorite)
    assert_equal bet.estimated_payout.round(2), 409.09
  end

  test 'Estimated payout for underdog' do
    bet = fixture(:bet__straight_underdog)
    bet.add_bet_odd(underdog)
    assert_equal bet.estimated_payout.round(2), 990
  end

  test 'Cannot add the same bet 3-team parlay' do
    bet = fixture(:bet__straight_favorite)
    bet.add_bet_odd(favorite)
    assert_raises(Sequel::UniqueConstraintViolation) { bet.add_bet_odd(favorite) }
  end

  test 'Estimated payout for 2-team parlay' do
    bet = fixture(:bet__straight_favorite)
    bet.add_bet_odd(favorite)
    bet.add_bet_odd(underdog)
    assert_equal bet.estimated_payout.round(2), 2299.09
  end

  test 'Estimated payout for 3-team parlay' do
    bet = fixture(:bet__straight_favorite)
    bet.add_bet_odd(favorite)
    bet.add_bet_odd(favorite_2)
    bet.add_bet_odd(favorite_3)
    assert_equal bet.estimated_payout.round(2), 2681.07
  end

  def favorite
    fixture(:bet_odd__moneyline_unplayed)
  end

  def underdog
    fixture(:bet_odd__moneyline_underdog)
  end

  def favorite_2
    fixture(:bet_odd__moneyline_won)
  end

  def favorite_3
    fixture(:bet_odd__moneyline_lost)
  end
end
