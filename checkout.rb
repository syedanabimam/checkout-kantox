class Checkout
  pricing_rules = {
    'GR1': gr1_pricing_rule,
    'SR1': sr1_pricing_rule,
    'CF1': cf1_pricing_rule
  }

  def initialize(pricing_rules)
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
      total += rules[item].call(quantity)
    end

    total
  end

  def gr1_pricing_rule(quantity)
    price = 3.11
    (quantity / 2 + quantity % 2) * price
  end

  def sr1_pricing_rule(quantity)
    price = quantity >= 3 ? 4.50 : 5.00
    quantity * price
  end

  def cf1_pricing_rule(quantity)
    price = 11.23
    price = (price * 2 / 3.0) if quantity >= 3
    quantity * price
  end
end

