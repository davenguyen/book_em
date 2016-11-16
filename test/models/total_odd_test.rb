require 'test_helper'

class TotalOddTest < ActiveSupport::TestCase
  test 'Total won 1' do
    assert fixture(:bet_odd__total_won1).covered!.covered?
  end

  test 'Total won 2' do
    assert fixture(:bet_odd__total_won2).covered!.covered?
  end

  test 'Total lost 1' do
    assert_not fixture(:bet_odd__total_lost1).covered!.covered?
  end

  test 'Total lost 2' do
    assert_not fixture(:bet_odd__total_lost2).covered!.covered?
  end
end
