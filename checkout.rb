require_relative 'pricing_rules_config'

class Checkout
  def initialize(pricing_rules = PRICING_RULES)
    @pricing_rules = pricing_rules
    @items = []
  end

  def scan(item)
    @items << item
  end

  def total
    apply(@items, @pricing_rules)
  end

  private

  def apply(items, pricing_rules)
    grouped_items = items.tally
    total = 0.0

    grouped_items.each do |item, quantity|
      total += pricing_rules[item].call(quantity)
    end

    total
  end
end
