## TokenBurnLeaderboard
This contract is a simple leaderboard that keeps track of the burners of a token. It is designed to be used with the [$TEX] contract, but it works with any ERC20 token.

1. Once the contract is deployed, a token contract is set, once its set there is no way to change it.

### How it works
In a period of time, the contract will be open to burning tokens. The contract will keep track of the burners and the amount of tokens they burned. At the end of the period, the contract will freeze the leaderboard and the burners will be rewarded with a prize.

### How to use
1. Deploy the contract
2. Call the `start` function to start the burning period
3. Burn tokens
4. Call the `stop` function to stop the burning period
5. Call the `getLeaderboard` function to get the leaderboard
6. Call the `claim` function to claim the prize
