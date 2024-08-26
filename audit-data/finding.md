## Low

### [L-1] Ownable parameter can't pass the code compiler static analysis

**Recommendation**

It will effect the static analysis of the code.

Remove the Ownable parameter.

Error: Wrong argument count for modifier invocation: 1 arguments given but expected 0.
  --> src/HoneyPotPurchaseOnETH.sol:32:87:
   |
32 |     constructor(address _usdtAddress, address _usdcAddress, address _treasuryAddress) Ownable(msg.sender) {
   |                                                                                       ^^^^^^^^^^^^^^^^^^^
Error: Wrong argument count for modifier invocation: 1 arguments given but expected 0.
  --> src/HoneyPotPurchaseOnBase.sol:34:85:
   |
34 |     constructor(address _usdcAddress, address _treasuryAddress,address _nftAddress) Ownable(msg.sender) {
   |                                                                                     ^^^^^^^^^^^^^^^^^^^
Error: Wrong argument count for modifier invocation: 1 arguments given but expected 0.
  --> src/HoneyPotPurchaseOnBNB.sol:31:87:
   |
31 |     constructor(address _usdtAddress, address _ethAddress,  address _treasuryAddress) Ownable(msg.sender) {
   |                                                                                       ^^^^^^^^^^^^^^^^^^^

## Information

### [I-1] Using different solc version

**Recommendation**

The NFT contract use version `^0.8.4`, but the other contract use `0.8.20`.

### [I-2] Using different import source

**Recommendation**

Using foundry.toml and set remappings, make the import same source or support the both import.

```
remappings = ['@openzeppelin/contracts=lib/openzeppelin-contracts/contracts']
```