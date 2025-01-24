# File to manage CLI Ops

require_relative 'checkout'
require_relative 'pricing_rules_config'

class MainCLI
  def initialize
    @checkout = Checkout.new(PricingRulesConfig::PRICING_RULES)
    @running = true
    @intro_displayed = false
    @scanned_items = []
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
    puts '4. Search items by name'
    puts '5. Show total'
    puts '6. Reset checkout'
    puts '7. Exit'
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
      search_items_by_name
    when '5'
      show_total
    when '6'
      reset_checkout
    when '7'
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
    available_items = [
      { code: 'GR1', name: 'Green Tea', price: 3.11 },
      { code: 'SR1', name: 'Strawberries', price: 5.00 },
      { code: 'CF1', name: 'Coffee', price: 11.23 }
    ]

    loop do
      puts "1. Back to menu | 2. View items | 3. View pricing rules"
      print 'Start typing to search (or type "menu" to go back): '
      input = gets.chomp.strip

      case input.downcase
      when 'menu', '1'
        return
      when '2'
        show_items
      when '3'
        show_pricing_rules
      else
        matches = available_items.select do |item|
          item[:code].downcase.include?(input.downcase) || item[:name].downcase.include?(input.downcase)
        end

        if matches.empty?
          puts 'No matching items found. Keep typing or type "menu" to go back.'
        else
          puts 'Matching items:'
          matches.each_with_index do |item, index|
            puts "#{index + 1}. #{item[:code]} (#{item[:name]}) - £#{'%.2f' % item[:price]}"
          end
          print 'Select item number to add, or refine search: '
          selection = gets.chomp.strip

          if selection.to_i.between?(1, matches.length)
            selected_item = matches[selection.to_i - 1]
            @scanned_items << selected_item
            @checkout.scan(selected_item[:code])
            puts "Item '#{selected_item[:name]}' scanned successfully."
            show_total
          else
            puts 'Invalid selection. Keep typing or refine search.'
          end
        end
      end
    end
  end

  def item_name(code)
    {
      'GR1' => 'Green Tea',
      'SR1' => 'Strawberries',
      'CF1' => 'Coffee'
    }[code]
  end

  def search_items_by_name
    print 'Enter part of the item name to search: '
    query = gets.chomp.strip.downcase
    available_items = [
      { code: 'GR1', name: 'Green Tea', price: 3.11 },
      { code: 'SR1', name: 'Strawberries', price: 5.00 },
      { code: 'CF1', name: 'Coffee', price: 11.23 }
    ]
    results = available_items.select do |item|
      item[:name].downcase.include?(query) || item[:code].downcase.include?(query)
    end
    if results.any?
      puts 'Matching items:'
      results.each do |item|
        puts "#{item[:code]} | #{item[:name]} | £#{'%.2f' % item[:price]}"
      end
    else
      puts 'No items found matching your query.'
    end
    puts
  end

  def show_total
    total_price = @checkout.total
    grouped_items = @scanned_items.group_by { |item| item[:code] }.map do |code, items|
      {
        code: code,
        name: items.first[:name],
        quantity: items.size,
        original_price: items.size * items.first[:price],
        discounted_price: @checkout.instance_variable_get(:@pricing_rules)[code].call(items.size)
      }
    end

    puts '======================================================'
    puts 'Items Scanned:'
    puts 'No. | Item Code | Name         | Quantity | Original Price | Discounted Price'
    grouped_items.each_with_index do |item, index|
      puts "#{(index + 1).to_s.ljust(3)} | #{item[:code].ljust(9)} | #{item[:name].ljust(12)} | #{item[:quantity].to_s.ljust(8)} | £#{'%.2f' % item[:original_price]}        | £#{'%.2f' % item[:discounted_price]}"
    end
    puts '------------------------------------------------------'
    puts format("Current Total: £%.2f", total_price)
    puts '======================================================'
    puts
  end

  def reset_checkout
    @checkout = Checkout.new(PricingRulesConfig::PRICING_RULES)
    puts 'Checkout reset. All scanned items have been cleared.'
    puts
  end

  def exit_program
    puts 'Thank you for using the Kantox Checkout System CLI. Au Revoir!'
    @running = false
  end
end

# Starts the CLI
MainCLI.new.run
