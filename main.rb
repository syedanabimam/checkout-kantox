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
    puts '======================================================'
    puts 'Welcome to the Kantox Checkout System CLI!'
    puts '======================================================'
    puts 'This is how the checkout logic is running in the background:'
    puts '  co = Checkout.new(PricingRulesConfig::PRICING_RULES)'
    puts "  co.scan('GR1')"
    puts "  co.scan('SR1')"
    puts '  price = co.total'
    puts '======================================================'
    puts "Let's get started!"
    puts
    @intro_shown = true
  end

  def show_menu
    puts 'What would you like to do?'
    puts '1. View items and prices'
    puts '2. View pricing rules'
    puts '3. Scan an item'
    puts '4. Show total'
    puts '5. Exit'
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
      scan_item_loop
    when '4'
      show_total
    when '5'
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

  def scan_item_loop
    loop do
      print 'Enter the item code to scan (or type "menu" to go back): '
      input = gets.chomp.strip

      if input.downcase == 'menu'
        return
      elsif %w[GR1 SR1 CF1].include?(input.upcase)
        @checkout.scan(input.upcase)
        puts "Item '#{input.upcase}' scanned successfully."
      else
        puts 'Invalid item code. Please try again or type "menu" to go back.'
      end
    end
  end

  def show_total
    total_price = @checkout.total
    puts "Current total: £#{'%.2f' % total_price}"
    puts
  end

  def exit_program
    puts 'Thank you for using the Kantox Checkout System CLI. Au Revoir!'
    @running = false
  end
end

# Starts the CLI
MainCLI.new.run
