# Dev-streak Smart Contract

A Clarity smart contract for tracking user contribution streaks on the Stacks blockchain.

## Features

- Log daily contributions and track streaks per user
- Store last block, current streak, longest streak, and total days for each user
- Read-only functions to query current streak, longest streak, and total contributions
- Admin reset functionality (currently disabled due to Clarity environment limitations)

## Contract Structure

- `log-contribution(current-block uint)`: Public function to log a contribution for the current block
- `get-current-streak(user principal)`: Read-only function to get a user's current streak
- `get-longest-streak(user principal)`: Read-only function to get a user's longest streak
- `get-total-contributions(user principal)`: Read-only function to get a user's total contribution days
- `reset-streak(user principal)`: Public function for admin to reset a user's streak (returns error in current version)

## Usage

1. Deploy the contract to your Stacks testnet or mainnet environment.
2. Call `log-contribution` with the current block height to log a user's daily contribution.
3. Use the read-only functions to query streak data for any user.

## Limitations

- Admin checks for `reset-streak` are not supported in the current Clarity environment.
- Principal comparison and conversion functions are unavailable; admin logic must be handled off-chain or with future Clarity updates.

## Development

- Contract source: `contracts/Dev-streak.clar`
- Tests: `tests/Dev-streak.test.ts`
- Configuration: `Clarinet.toml`, `settings/`
