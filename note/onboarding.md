# "Honey Pot" NFT Contracts

These smart contracts are the entry points for users to participate in honeypot NFT on Ethereum, Binance Smart Chain, and Base. 
After participating in minting NFT, the holder can get reward by invite other users.
**NOTE**: The ethereum contract can't recevice across the chain data, so the rewards will be delay to send.


# Stats
| Language | files | blank | comment | code |
|----------|-------|-------|---------|------|
| Solidity | 4 | 109 | 4| 358 |

## Complex Scope

## Security Review Timeline
2024-08-22 16:00:00


# Setup

## Requirements
```
$ foundryup

$ forge -help

$ cast -help

$ chisel
```

## QuickStart

```
git clone https://github.com/DAOBase-AI/Honey_pot_contract.git
cd Honey_pot_contract

```


## Test



# Scope

## Commit Hash
42d631c5c721c3d18c941744d8b70a94028e0959

## In scope or out of scope Contracts

```
./src/
└── HoneyPotNFT.sol
└── HoneyPotPurchaseOnBase.sol
└── HoneyPotPurchaseOnBNB.sol
└── HoneyPotPurchaseOnETH.sol
```

# Compatibilities
- Solidity version:
- Chains to deploy contracts to:
  - Ethereum:
  - Base:
  - Binance Smart Chain:
- Tokens:
- NFT: Honey Pot NFT
 
# Roles
- What are the different actors of the system?
- What are their powers?
- What should / shouldn't they do?

## Owner
- [Warning] Owner can make the contract access to blackhole.
- Owner can mint NFT to some where.
- Owner can set the token price and update Referrer.
- Owner can set the contract treasury address in initialization.

## Outsider
-- Outsider can buy NFT with ETH\USDT\USDC in the Ethereum\Binance Smart Chain\Base.

# Known Issues
- The contract on Ethereum can't sync the nft buyer data for another chains, coz the gas cost on Ethereum is too high;
