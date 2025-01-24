## About
The repository contains the Kantox Checkout System, a simple cashier-like functionality that allows adding products to a cart, applying pricing rules, and calculating the total price. The system is enhanced with a Command Line Interface (CLI) to make operations seamless for users.

---

## Features

1. Core Checkout Functionality:

- Add products to the cart (scan method).

- Apply predefined pricing rules.

- Calculate the total price based on items in the cart.


2. CLI Features:

- View available items and prices.

- View pricing rules for items.

- Scan items into the cart.

- Add or remove custom items with custom pricing rules.

- Display the total price for scanned items.

- Reset the cart to start fresh.

- Exit the CLI gracefully.

----

## Testing
The test suite is written using Minitest.

### Running Tests
To run the tests, execute:
```bash
ruby test.rb
```

### Test Cases
The following test cases are included:
1. **Test Case 1**:
   Scans items `GR1`, `SR1`, `GR1`, `GR1`, and `CF1`. Verifies the total price is `£22.45`.
2. **Test Case 2**:
   Scans items `GR1` and `GR1`. Verifies the total price is `£3.11`.
3. **Test Case 3**:
   Scans items `SR1`, `SR1`, `GR1`, and `SR1`. Verifies the total price is `£16.61`.
4. **Test Case 4**:
   Scans items `GR1`, `CF1`, `SR1`, `CF1`, and `CF1`. Verifies the total price is `£30.57`.

### Sample Test Output
```plaintext
CheckoutTest
  test_case1
    ✓ test_case1 (0.001s)
  test_case2
    ✓ test_case2 (0.000s)
  test_case3
    ✓ test_case3 (0.001s)
  test_case4
    ✓ test_case4 (0.000s)

Finished in 0.00345s
4 tests, 4 assertions, 0 failures, 0 errors, 0 skips
```

---

## File Structure
```
checkout_system_cli/
├── main.rb                  # Main entry point for the CLI.
├── checkout.rb              # Core logic for scanning and calculating totals.
├── pricing_rules_config.rb  # Predefined pricing rules.
├── test.rb                  # Minitest test suite.
└── README.md                # Documentation.
```

---

## Notes
- All scanned items, custom items, and totals are reset upon application restart.
- Ensure item codes are unique when adding custom items.
- For any issues or feature requests, please open an issue in the repository.

---
