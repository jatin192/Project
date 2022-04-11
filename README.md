# Project

# Coin-Flip
Coin Flip” betting game in the Solidity language using the Harmony testnet and Harmony VRF (Verifiable Random Function)

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
