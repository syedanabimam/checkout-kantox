# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'checkout'

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

class CheckoutTest < Minitest::Test
  def setup
    @checkout = Checkout.new(Checkout::PRICING_RULES)
  end

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
end
