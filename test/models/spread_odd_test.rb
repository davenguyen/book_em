require 'test_helper'

class SpreadOddTest < ActiveSupport::TestCase
  test 'Spread won 1' do
    assert fixture(:bet_odd__spread_won1).covered!.covered?
  end

  test 'Spread won 2' do
    assert fixture(:bet_odd__spread_won2).covered!.covered?
  end

  test 'Spread won 3' do
    assert fixture(:bet_odd__spread_won3).covered!.covered?
  end

  test 'Spread won 4' do
    assert fixture(:bet_odd__spread_won4).covered!.covered?
  end

  test 'Spread lost 1' do
    assert_not fixture(:bet_odd__spread_lost1).covered!.covered?
  end

  test 'Spread lost 2' do
    assert_not fixture(:bet_odd__spread_lost2).covered!.covered?
  end

  test 'Spread lost 3' do
    assert_not fixture(:bet_odd__spread_lost3).covered!.covered?
  end

  test 'Spread lost 4' do
    assert_not fixture(:bet_odd__spread_lost4).covered!.covered?
  end
end
