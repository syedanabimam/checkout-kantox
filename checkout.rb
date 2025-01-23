class Checkout
  def self.calculate_gr1_price(quantity)
    price = 3.11
    (quantity / 2 + quantity % 2) * price
  end

  def self.calculate_sr1_price(quantity)
    price = quantity >= 3 ? 4.50 : 5.00
    quantity * price
  end

  def self.calculate_cf1_price(quantity)
    price = 11.23
    price = (price * 2 / 3.0) if quantity >= 3
    quantity * price
  end

  PRICING_RULES = {
    'GR1' => method(:calculate_gr1_price),
    'SR1' => method(:calculate_sr1_price),
    'CF1' => method(:calculate_cf1_price)
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
