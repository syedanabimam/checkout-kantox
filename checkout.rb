class Checkout
  PRICING_RULES = {
    'GR1' => lambda do |quantity|
      unit_price = 3.11
      (quantity / 2 + quantity % 2) * unit_price
    end,
    'SR1' => lambda do |quantity|
      unit_price = quantity >= 3 ? 4.50 : 5.00
      quantity * unit_price
    end,
    'CF1' => lambda do |quantity|
      unit_price = 11.23
      unit_price = (unit_price * 2 / 3.0) if quantity >= 3
      quantity * unit_price
    end
  }.freeze

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
