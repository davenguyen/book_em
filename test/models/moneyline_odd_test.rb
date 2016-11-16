require 'test_helper'

class MoneylineOddTest < ActiveSupport::TestCase
  test 'Game not played' do
    assert_nil fixture(:bet_odd__moneyline_unplayed).covered!
  end

  test 'won' do
    assert fixture(:bet_odd__moneyline_won).covered!.covered?
  end

  test 'Moneyline lost' do
    assert_not fixture(:bet_odd__moneyline_lost).covered!.covered?
  end
end
