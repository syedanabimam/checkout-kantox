# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'checkout'

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

class CheckoutTest < Minitest::Test
  def setup
    @checkout = Checkout.new(PricingRulesConfig::PRICING_RULES)
  end

  # Predefined Test Cases
  def test_case1
    @checkout.scan('GR1')
    @checkout.scan('SR1')
    @checkout.scan('GR1')
    @checkout.scan('GR1')
    @checkout.scan('CF1')
    assert_equal 22.45, @checkout.total
  end

  def test_case2
    @checkout.scan('GR1')
    @checkout.scan('GR1')
    assert_equal 3.11, @checkout.total
  end

  def test_case3
    @checkout.scan('SR1')
    @checkout.scan('SR1')
    @checkout.scan('GR1')
    @checkout.scan('SR1')
    assert_equal 16.61, @checkout.total
  end

  def test_case4
    @checkout.scan('GR1')
    @checkout.scan('CF1')
    @checkout.scan('SR1')
    @checkout.scan('CF1')
    @checkout.scan('CF1')
    assert_equal 30.57, @checkout.total
  end

  # Additional Test Cases
  def test_no_items_scanned
    assert_equal 0.0, @checkout.total
  end

  def test_large_quantity
    1000.times { @checkout.scan('GR1') }
    assert_equal 1555.0, @checkout.total
  end

  def test_custom_item
    custom_rule = lambda { |quantity| quantity * 2.0 }
    @checkout = Checkout.new(PricingRulesConfig::PRICING_RULES.merge('ANAB' => custom_rule))
    @checkout.scan('ANAB')
    @checkout.scan('ANAB')
    assert_equal 4.0, @checkout.total
  end

  def test_mix_of_custom_and_predefined_items
    custom_rule = lambda { |quantity| quantity * 2.0 }
    @checkout = Checkout.new(PricingRulesConfig::PRICING_RULES.merge('ANAB' => custom_rule))
    @checkout.scan('GR1')
    @checkout.scan('ANAB')
    assert_equal 5.11, @checkout.total
  end

  def test_custom_buy_x_get_y_free
    custom_rule = lambda do |quantity|
      unit_price = 2.0
      # Buy 3, Get 1 Free
      (quantity / 4 * 3 + quantity % 4) * unit_price
    end
    @checkout = Checkout.new(PricingRulesConfig::PRICING_RULES.merge('ANAB' => custom_rule))
    6.times { @checkout.scan('ANAB') }
    assert_equal 10.0, @checkout.total
  end

  def test_bulk_discount_sr1
    3.times { @checkout.scan('SR1') }
    assert_equal 13.5, @checkout.total
  end

  def test_bulk_discount_cf1
    3.times { @checkout.scan('CF1') }
    assert_equal 22.46, @checkout.total
  end

  def test_invalid_item
    assert_raises(ArgumentError) do
      @checkout.scan('INVALID')
      @checkout.total
    end
  end

  def test_reset_checkout
    @checkout.scan('GR1')
    @checkout.scan('SR1')
    @checkout = Checkout.new(PricingRulesConfig::PRICING_RULES)
    assert_equal 0.0, @checkout.total
  end

  def test_order_independence
    @checkout.scan('GR1')
    @checkout.scan('SR1')
    @checkout.scan('GR1')
    @checkout.scan('CF1')
    @checkout.scan('GR1')

    @checkout = Checkout.new(PricingRulesConfig::PRICING_RULES)
    @checkout.scan('CF1')
    @checkout.scan('SR1')
    3.times { @checkout.scan('GR1') }

    assert_equal 22.45, @checkout.total
  end

  def test_single_item
    @checkout.scan('SR1')
    assert_equal 5.00, @checkout.total
  end
end
