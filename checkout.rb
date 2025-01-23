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
end

