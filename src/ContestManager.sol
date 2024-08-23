// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Pot} from "./Pot.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract ContestManager is Ownable {
    address[] public contests;
    mapping(address => uint256) public contestToTotalRewards;

    error ContestManager__InsufficientFunds();

    constructor() Ownable(msg.sender) {}

    function createContest(address[] memory players, uint256[] memory rewards, IERC20 token, uint256 totalRewards)
        public
        onlyOwner
        returns (address)
    {
        // Create a new Pot contract
        Pot pot = new Pot(players, rewards, token, totalRewards);
        contests.push(address(pot));
        contestToTotalRewards[address(pot)] = totalRewards;
        return address(pot);
    }

    function fundContest(uint256 index) public onlyOwner {
        Pot pot = Pot(contests[index]);
        IERC20 token = pot.getToken();
        uint256 totalRewards = contestToTotalRewards[address(pot)];

        if (token.balanceOf(msg.sender) < totalRewards) {
            revert ContestManager__InsufficientFunds();
        }

        token.transferFrom(msg.sender, address(pot), totalRewards);
    }

    function getContests() public view returns (address[] memory) {
        return contests;
    }

    function getContestTotalRewards(address contest) public view returns (uint256) {
        return contestToTotalRewards[contest];
    }

    function getContestRemainingRewards(address contest) public view returns (uint256) {
        Pot pot = Pot(contest);
        return pot.getRemainingRewards();
    }

    function closeContest(address contest) public onlyOwner {
        _closeContest(contest);
    }

    function _closeContest(address contest) internal {
        Pot pot = Pot(contest);
        pot.closePot();
    }
}
