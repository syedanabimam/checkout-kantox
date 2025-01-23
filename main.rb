# File to manage CLI Ops

require_relative 'checkout'
require_relative 'pricing_rules_config'

class MainCLI
  def initialize
    @checkout = Checkout.new(PricingRulesConfig::PRICING_RULES)
  end

  def run
    show_intro
    show_menu
  end

  private

  def show_intro
    'This is the CLI to manage Kantox Checkout Os'
  end

  def show_menu
    puts 'What would you like to do?'
    puts '1. View items and prices'
    puts '2. View pricing rules'
    puts '3. Exit'
    print 'Enter your choice: '
  end

  def exit_program
    puts 'Thank you for using the Kantox Checkout System CLI. Au Revoir!'
  end
end

# Starts the CLI
MainCLI.new.run
