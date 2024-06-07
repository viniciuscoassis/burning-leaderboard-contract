// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// type declarations
// state variables
// events
// modifiers
// functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenBurnLeaderboard is Ownable(msg.sender) {

    // Errors
    error TokenBurnLeaderboard__MustBeMoreThanZero();
    error TokenBurnLeaderboard__BurnFailed();

    IERC20 private token;
    address private constant burnAddress = 0x000000000000000000000000000000000000dEaD; 
    
    struct BurnEntry {
        address user;
        uint256 amount;
        uint256 timestamp;
    }
    
    BurnEntry[] private burnEntries;
    mapping(address => uint256) private totalBurned;

    event TokensBurned(address indexed user, uint256 amount, uint256 timestamp);
    event LeaderboardUpdated(address indexed user, uint256 totalAmountBurned);

    /////////////////
    // Modifiers   //
    /////////////////
    modifier moreThanZero(uint256 _amount) {
        if (_amount <= 0) {
            revert TokenBurnLeaderboard__MustBeMoreThanZero();
        }
        _;
    }

    //////////////////
    // Constructor  //
    //////////////////
    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    function burnTokens(uint256 amount) external moreThanZero(amount) {
        (bool success) = token.transferFrom(msg.sender, burnAddress, amount);
        if (!success) {
            revert TokenBurnLeaderboard__BurnFailed();
        }

        totalBurned[msg.sender] += amount;

        BurnEntry memory entry = BurnEntry({
            user: msg.sender,
            amount: amount,
            timestamp: block.timestamp
        });

        burnEntries.push(entry);

        emit TokensBurned(msg.sender, amount, block.timestamp);
        emit LeaderboardUpdated(msg.sender, totalBurned[msg.sender]);
    }

    function getLeaderboard() external view returns (BurnEntry[] memory) {
        return burnEntries;
    }

    function getTotalBurnedByUser(address user) external view returns (uint256) {
        return totalBurned[user];
    }

    function getTokenAddress() external view returns (address) {
        return address(token);
    }

}