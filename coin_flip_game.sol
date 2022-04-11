// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

//Limitation
//If smart contract does'nt have enough fund that it will pay double  money to account who wins -> then  this program  is  not  workiking
//if you  want to resolve this  problem  you should send Backup money for emergency funds in Beginning
//for example account A,B,C contribute 2,2,10 Ether in smart contract and A,B wins then program work  properly
//but  if A,C wins so total  money in smart contract is  14 Ether but you have to pay 24 Ether(2*2+10*2) to A,C so  at that time  Program fails

//--------------------------------------------------------------------------------------------------------------------

//if you are using Ganache
//Set up local Harmony chain Ganache
//Load Harmony networks (local, testnet, mainnet) to ganache-cli.
//Use web3.js to interact with the ganache binded harmony network

//for implementation  of RandomNumber
//you have select Injected Web3 in ENVIRONMENT in Remix
// i am using Rinkeby testnet Coordinator Parameters i you want any  other testnet you can simply change parameter from this Link:{https://docs.chain.link/docs/vrf-contracts/}


contract flip_game is  VRFConsumerBase
{
    event Wins(address Address_,uint Profit_Money);
    event Transaction_take_place(address from_,uint Money_);
    mapping(address=>uint) balance; //Store the user’s bet in the smart contract using mappings
    mapping(address=>uint) check; //check that same user to place single bets
    mapping(uint=> address) m;   //storing  the addresses so  that i can access easily
    //you can also use structure for this

    uint a=0;
    uint b=0; //number of contributors
    uint c=0;
    //*****
    //if you are getting an error you have to use send some money in form  of emergency fund so that smart contract have enough fund to work properly
    function send_emergency_fund() public payable  // Backup_Money
    {

    }
    function send_Money_to_smart_contract() public payable 
    {
        require(check[msg.sender]==0,"Do not allow the same user to place multiple bets if they have an existing undecided bet");
        require((100 >= msg.value/1 ether),"not have enough fund jatin");   //do not allow a bet more than the balance they have
        check[msg.sender]=1;
        balance[msg.sender]=100-(msg.value/1 ether);
        m[a]=msg.sender;
        a++;
        b++;
        emit Transaction_take_place(msg.sender,msg.value);
    }
//-------------------------------------------------------------------------------------------------------------------
//Use VRF to generate a random number and decide heads or tails

    bytes32 internal keyHash;
    uint256 internal fee;
    
    uint256 public randomResult;
    
    constructor() 
        VRFConsumerBase(
            0x6168499c0cFfCaCD319c818142124B7A15E857ab, // VRF Coordinator
            0x01BE23585060835E02B77ef475b0Cc51aA1e0709  // LINK Token
        ) public
    {
        keyHash = 0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc;
        fee = 0.1 * 10 ** 18; // 0.1 LINK (Varies by network)
    }
    
    function getRandomNumber() public  returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK - fill contract with faucet");
        return requestRandomness(keyHash, fee);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        randomResult = (randomness % 2) + 1;                                                   //for Head  and Tail
    }

//-------------------------------------------------------------------------------------------------------------------
    function rewardBets() public 
    {
        for(uint i=0;i<b;i++)
        {
            getRandomNumber();
            if(randomResult==1)
            {
                c =  (100-balance[m[i]])*2;                           //If win, double the user’s bet amount and add it to their balance (i.e. they got 2x on their money)
                payable(m[i]).transfer(c*1000000000000000000);               // 1 Ether =10^18 Wei 
                balance[msg.sender]=100+c;
                emit Wins(m[i],c);                                  //Emit an event containing gambler address and bet amount for every win
            }
        }
    }
    function Check_Money_in_Smart_contractt() public view returns (uint)     //you can check totol balance in smart contract  
    {
        return address(this).balance;
    }

//------------------------------------------------------------------------------------------------------------------
    // function check_Balance(address  adrs) public view returns (uint)
    // {
    //     return balance[adrs];
    // }
}
