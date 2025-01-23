## About
The repo is for kantox checkout that is a simple cashier function that adds products to a cart and displays the total price.

---

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
