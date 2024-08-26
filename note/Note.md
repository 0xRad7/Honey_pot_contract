# Onboarding Doc

- Write Onboarding Doc

# Static analysis

# Scoping 

- the `Ownable` parameter effect the static analysis to the code;

```
    constructor(address _usdtAddress, address _usdcAddress, address _treasuryAddress) Ownable(msg.sender) {
```

- Reentrancy warning validation
- HoneyPotPurchaseOnETH.t.sol

# Role description