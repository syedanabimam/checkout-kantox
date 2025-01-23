# File to manage CLI Ops

require_relative 'checkout'
require_relative 'pricing_rules_config'

class MainCLI
  def initialize
    @checkout = Checkout.new(PricingRulesConfig::PRICING_RULES)
    @running = true
    @intro_displayed = false
  end

  def run
    show_intro unless @intro_displayed

    while @running
      show_menu
      handle_user_input
    end
  end

  private

  def show_intro
    'This is the CLI to manage Kantox Checkout Os'
    puts
    @intro_shown = true
  end

  def show_menu
    puts 'What would you like to do?'
    puts '1. View items and prices'
    puts '2. View pricing rules'
    puts '3. Exit'
    print 'Enter your choice: '
  end

  def handle_user_input
    choice = gets.chomp

    case choice
    when '1'
      show_items
    when '2'
      show_pricing_rules
    when '3'
      exit_program
    else
      puts 'Invalid choice. Please try again.'
    end
  end

  def show_items
    puts '======================================================'
    puts 'Available items and their prices:'
    puts 'Item Code | Name          | Price'
    puts 'GR1       | Green Tea     | £3.11'
    puts 'SR1       | Strawberries  | £5.00'
    puts 'CF1       | Coffee        | £11.23'
    puts '======================================================'
    puts
  end

  def show_pricing_rules
    puts '======================================================'
    puts 'Pricing Rules:'
    puts '1. Buy-one-get-one-free on Green Tea (GR1).'
    puts '2. Bulk discount on Strawberries (SR1) - Price drops to £4.50 each for 3 or more.'
    puts '3. Bulk discount on Coffee (CF1) - Price drops to two-thirds of £11.23 each for 3 or more.'
    puts '======================================================'
    puts
  end

  def exit_program
    puts 'Thank you for using the Kantox Checkout System CLI. Au Revoir!'
    @running = false
  end
end

# Starts the CLI
MainCLI.new.run
