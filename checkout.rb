require_relative 'pricing_rules_config'

class Checkout
  def initialize(pricing_rules = PricingRulesConfig::PRICING_RULES)
    @pricing_rules = pricing_rules
    @items = []
  end

  def scan(item)
    items << item
  end

  def total
    apply(items, pricing_rules)
  end

  private

  attr_reader :pricing_rules, :items

  def apply(items, pricing_rules)
    grouped_items = items.tally
    total = 0.0

    grouped_items.each do |item, quantity|
      total += pricing_rules[item].call(quantity)
    end

    # Rounding to 2 to ensure the total is in same decimal config as prices
    total.round(2)
  end
end
