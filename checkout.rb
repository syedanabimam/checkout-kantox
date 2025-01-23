class Checkout
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
    # tally items count
    # refer to pricing rules
    # apply rule to each item
    # calculate total
  end

  def pricing_rules
    {
      'GR1': gr1_pricing_rule,
      'SR1': sr1_pricing_rule,
      'CF1': cf1_pricing_rule
    }
  end

  def gr1_pricing_rule
    price = 3.11
  end

  def sr1_pricing_rule
    price = 5.00
  end

  def cf1_pricing_rule
    price = 11.23
  end
end

