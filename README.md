# Project
# Coin-Flip Overview
- Coin Flip Game is to be a smart contract using **Harmony VRF** function
- Allows a user to place a bet on a particular outcome of a coin flip using a function that accepts amount = integer and bet = 0 or 1 representing heads or tails
    - Store the user’s balance in a mapping. By default, each address gets 100 points free to start.
    - Store the user’s bet in the smart contract using mappings / arrays and structs as seems best
        - Deduct their balance based on the bet amount
        - do not allow a bet more than the balance they have
    - Allow multiple bets to be placed using the same function, i.e., different wallet can interact with the smart contract to place different bets
    - Don’t allow the same user to place multiple bets if they have an existing undecided bet
- Some time later, another function “rewardBets” is used to generate random num and conclude all bets with win/loss
    - Use VRF to generate a random number and decide heads or tails
    - Go through all bets
        - If win, double the user’s bet amount and add it to their balance (i.e. they got 2x on their money)
        - If loss, no balance to be transferred (as balance already deducted at time of making bet)
        - In either case, conclude the bet by setting a flag or moving the bet to a different mapping “completedBets” which is separate from “ongoingBets”
        - Emit an event containing gambler address and bet amount for every win
# steps to follow
Due to some Limitation we have to send some Backup money to  smart contract so that it will  work properly

step 1->      open Remix and call send_emergency_fund()  function.

step 2->      call send_Money_to_smart_contract() for different account.

              ->you can also check balance in smart contract by calling Check_Money_in_Smart_contractt();
              
step 3->      call rewardBets() that will call getRandomNumber automatically
              now You can check the balance of some accounts now that it has increased 


for example 
-----------
if Account A,B,C send 2,2,10 Ether in smart contract and A,B wins then program work  properly
but  if A,C wins so total  money in smart contract is  14 Ether but you have to pay 24 Ether((2)(2)+(10)(2)) to A,C so at that time  Program fails
for  this  reason  we have to send some Backup money(=10 Ether acc. example) to  smart contract so that it will  work properly

if you are using Ganache
------------------------
Set up local Harmony chain Ganache

Load Harmony networks (local, testnet, mainnet) to ganache-cli.

Use web3.js to interact with the ganache binded harmony network


for implementation  of RandomNumber
----------------------------------

you have select Injected Web3 in ENVIRONMENT in Remix

i am using Rinkeby testnet Coordinator Parameters if you want to use use any other testnet you can simply change parameter from this Link:{https://docs.chain.link/docs/vrf-contracts/}
