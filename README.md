# First Flight #23: MyCut

### Prize Pool

- High - 100 XP
- Medium - 20 XP
- Low - 2 XP

- Starts: August, 29 2024 Noon UTC

- Ends: September 05, 2024 Noon UTC

- nSLOC: 106

[//]: # (contest-details-open)

## About the Project

MyCut is a contest rewards distribution protocol which allows the set up and management of multiple rewards distributions, allowing authorized claimants 90 days to claim before the manager takes a cut of the remaining pool and the remainder is distributed equally to those who claimed in time!

### Actors

- Owner/Admin (Trusted) - Is able to create new Pots, close old Pots when the claim period has elapsed and fund Pots
- User/Player - Can claim their cut of a Pot

[//]: # (contest-details-close)

[//]: # (scope-open)

## Scope (contracts)

All Contracts in `src` are in scope.

```js
src/
├── ContestManager.sol
├── Pot.sol
```

## Compatibilities

- Blockchains: EVM Equivalent Chains Only
- Tokens: Standard ERC20 Tokens Only


[//]: # (scope-close)

[//]: # (getting-started-open)

## Setup

Clone the repo
```bash
git clone https://github.com/Cyfrin/2024-08-MyCut.git
```
Open in VSCode
```bash
code 2024-08-MyCut/
```

Build and run tests
```bash
forge test
```


[//]: # (getting-started-close)

[//]: # (known-issues-open)

## Known Issues

- No known issues

[//]: # (known-issues-close)
