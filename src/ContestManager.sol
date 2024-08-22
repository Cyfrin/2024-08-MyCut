// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Pot} from "./Pot.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract ContestManager is Ownable(msg.sender) {
    address[] public contests;
    mapping(address => uint256) public contestToTotalRewards;

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
