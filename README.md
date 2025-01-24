## About

The repository contains the Kantox Checkout System, a simple cashier-like functionality that allows adding products to a cart, applying pricing rules, and calculating the total price. The system is enhanced with a Command Line Interface (CLI) to make operations seamless for users.

The test file test.rb demonstrates the way it was desired in assessment documentation on how code was supposed to run:
```BASH
  # I condensed the Pricing Rules to be lambda functions composed in a hash that lives in a module
  co = Checkout.new(PricingRulesConfig::PRICING_RULES)
  co.scan('GR1')
  co.scan('SR1')
  price = co.total
```

For more advanced usage, please explore the documentation below :point_down:

---

## Table of Contents

1. [About](#about)
2. [Features](#features)
3. [Running the CLI](#running-the-cli)
   - [Example Workflow](#example-workflow)
   - [Scanning Items](#scanning-items)
   - [Adding and Removing Custom Items](#adding-and-removing-custom-items)
   - [Showing Total with Tabular Format](#showing-total-with-tabular-format)
   - [Resetting the Cart](#resetting-the-cart)
   - [Viewing Items and Pricing (Including Custom Items)](#viewing-items-and-pricing-including-custom-items)
4. [Testing](#testing)
   - [Running Tests](#running-tests)
   - [Test Cases](#test-cases)
   - [Sample Test Output](#sample-test-output)
5. [File Structure](#file-structure)

---

## Features

1. **Core Checkout Functionality**:
   - Add products to the cart (`scan` method).
   - Apply predefined pricing rules.
   - Calculate the total price based on items in the cart.

2. **CLI Features**:
   - View available items and prices.
   - View pricing rules for items.
   - Scan items into the cart.
   - Add or remove custom items with custom pricing rules.
   - Display the total price for scanned items.
   - Reset the cart to start fresh.
   - Exit the CLI gracefully.

---

## Running the CLI

To use the CLI for operations:

1. Start the CLI by running:
   ```bash
   ruby main.rb
   ```
2. Follow the menu prompts to:
   - View items and pricing.
   - Add or remove items.
   - Scan items into the cart.
   - Calculate totals.
   - Add custom items with special pricing rules.
   - Reset the cart.

### Example Workflow
```plaintext
======================================================
Welcome to the Checkout System CLI!
======================================================
This is how the checkout logic is running in the background:
  co = Checkout.new(PricingRulesConfig::PRICING_RULES)
  co.scan('GR1')
  co.scan('SR1')
  price = co.total
======================================================
Let's get started!

What would you like to do?
1. View items and prices
2. View pricing rules
3. Scan an item
4. Search items by name
5. Add a new custom item
6. Remove a custom item
7. Show total
8. Reset checkout
9. Exit
Enter your choice:
```

### Scanning Items

The following demonstrates scanning items in different scenarios:

#### 1. Scanning Predefined Items by Full Code
```bash
Start typing to search (or type "menu" to go back): GR1
Item 'Green Tea' scanned successfully.
Current Total: £3.11
```

#### 2. Scanning Predefined Items by Partial Code
```bash
Start typing to search (or type "menu" to go back): GR
Matching items:
1. GR1 (Green Tea) - £3.11
Select item number to add, or refine search: 1
Item 'Green Tea' scanned successfully.
Current Total: £3.11
```

#### 3. Scanning Items by Name
```bash
Start typing to search (or type "menu" to go back): Green Tea
Matching items:
1. GR1 (Green Tea) - £3.11
Select item number to add, or refine search: 1
Item 'Green Tea' scanned successfully.
Current Total: £3.11
```

#### 4. Scanning Custom Items
```bash
Start typing to search (or type "menu" to go back): ANAB
Item 'Anab Imam' scanned successfully.
Current Total: £2.00
```

#### 5. Handling Invalid Input
```bash
Start typing to search (or type "menu" to go back): INVALID
No matching items found. Keep typing or type "menu" to go back.
```

---

### Adding and Removing Custom Items

#### Adding a Custom Item
```bash
Enter your choice: 5
Enter new item code: ANAB
Enter item name: Anab Imam
Enter item price: 2.00
What pricing rule do you want to apply?
1. Buy X, Get Y Free (e.g., Buy 1 Get 1 Free)
2. Bulk discount (Price drops to X if buying Y or more)
3. Bulk discount as fraction (e.g., 2/3 of price if buying Y or more)
Enter your choice: 1
Enter X (quantity to buy): 3
Enter Y (quantity to get free): 1
Custom item 'Anab Imam' with rule 'Buy 3, Get 1 Free' added successfully!
```

#### Removing a Custom Item
```bash
Enter your choice: 6
Enter the code of the custom item to remove: ANAB
Custom item 'ANAB' removed successfully.
```

---

### Showing Total with Tabular Format

#### Total Price Breakdown
```bash
======================================================
Items Scanned:
No. | Item Code | Name         | Quantity | Original Price | Discounted Price
1   | GR1       | Green Tea    | 4        | £12.44         | £6.22
2   | SR1       | Strawberries | 1        | £5.00          | £5.00
3   | CF1       | Coffee       | 1        | £11.23         | £11.23
4   | ANAB      | Anab Imam    | 4        | £8.00          | £6.00
------------------------------------------------------
Current Total: £28.45
======================================================
```

---

### Resetting the Cart

```bash
Enter your choice: 8
Checkout reset. All scanned items and custom items have been cleared.
```

---

### Viewing Items and Pricing (Including Custom Items)

#### Viewing Items
```bash
======================================================
Available items and their prices:
Item Code | Name          | Price
GR1       | Green Tea     | £3.11
SR1       | Strawberries  | £5.00
CF1       | Coffee        | £11.23
ANAB      | Anab Imam     | £2.00
======================================================
```

#### Viewing Pricing Rules
```bash
======================================================
Pricing Rules:
1. Buy-one-get-one-free on Green Tea (GR1).
2. Bulk discount on Strawberries (SR1) - Price drops to £4.50 each for 3 or more.
3. Bulk discount on Coffee (CF1) - Price drops to two-thirds of £11.23 each for 3 or more.
Custom rule for Anab Imam (ANAB): Buy 3, Get 1 Free
======================================================
```

---

## Testing

The test suite is written using Minitest to validate core functionality of the checkout logic.

### Running Tests

To run the tests, execute:
```bash
ruby test.rb
```

### Test Cases

The following predefined test cases are included to validate the checkout system:

1. **Test Case 1**:
   - Scans items: `GR1`, `SR1`, `GR1`, `GR1`, `CF1`.
   - Verifies the total price is `£22.45`.

2. **Test Case 2**:
   - Scans items: `GR1`, `GR1`.
   - Verifies the total price is `£3.11`.

3. **Test Case 3**:
   - Scans items: `SR1`, `SR1`, `GR1`, `SR1`.
   - Verifies the total price is `£16.61`.

4. **Test Case 4**:
   - Scans items: `GR1`, `CF1`, `SR1`, `CF1`, `CF1`.
   - Verifies the total price is `£30.57`.

### Sample Test Output

```plaintext
CheckoutTest
  test_case3                                                      PASS (0.00s)
  test_single_item                                                PASS (0.00s)
  test_bulk_discount_cf1                                          PASS (0.00s)
  test_bulk_discount_sr1                                          PASS (0.00s)
  test_no_items_scanned                                           PASS (0.00s)
  test_reset_checkout                                             PASS (0.00s)
  test_order_independence                                         PASS (0.00s)
  test_custom_item                                                PASS (0.00s)
  test_invalid_item                                               PASS (0.00s)
  test_custom_buy_x_get_y_free                                    PASS (0.00s)
  test_mix_of_custom_and_predefined_items                         PASS (0.00s)
  test_case1                                                      PASS (0.00s)
  test_large_quantity                                             PASS (0.00s)
  test_case4                                                      PASS (0.00s)
  test_case2                                                      PASS (0.00s)

Finished in 0.00153s
15 tests, 15 assertions, 0 failures, 0 errors, 0 skips
```
