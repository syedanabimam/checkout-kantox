module PricingRulesConfig
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
end
