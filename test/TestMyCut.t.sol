// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ContestManager} from "../src/ContestManager.sol";
import {Test, console} from "lib/forge-std/src/Test.sol";
import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {ERC20Mock} from "./ERC20Mock.sol";

contract TestMyCut is Test {
    address conMan;
    address player1 = makeAddr("player1");
    address player2 = makeAddr("player2");
    address[] players = [player1, player2];
    uint256 public constant STARTING_USER_BALANCE = 10 ether;
    ERC20Mock weth;
    address contest;
    address[] totalContests;
    uint256[] rewards;
    address user = makeAddr("user");

    function setUp() public {
        vm.startPrank(user);
        // DeployContestManager deploy = new DeployContestManager();
        conMan = address(new ContestManager());
        weth = new ERC20Mock("WETH", "WETH", msg.sender, 1000e8);
        // console.log("WETH Address: ", address(weth));
        // console.log("Test Address: ", address(this));
        console.log("User Address: ", user);
        // (conMan) = deploy.run();
        console.log("Contest Manager Address 1: ", address(conMan));
        vm.stopPrank();
        rewards = [3, 1];
    }

    modifier mintAndApproveTokens() {
        console.log("Minting tokens to: ", user);
        vm.startPrank(user);
        ERC20Mock(weth).mint(user, STARTING_USER_BALANCE);
        ERC20Mock(weth).approve(conMan, STARTING_USER_BALANCE);
        console.log("Approved tokens to: ", address(conMan));
        vm.stopPrank();
        _;
    }

    function testCanCreatePot() public mintAndApproveTokens {
        console.log("Contest Manager Owner: ", ContestManager(conMan).owner());
        console.log("msg.sender: ", msg.sender);
        vm.startPrank(user);
        contest = ContestManager(conMan).createContest(players, rewards, IERC20(ERC20Mock(weth)), 4);
        totalContests = ContestManager(conMan).getContests();
        vm.stopPrank();
        assertEq(totalContests.length, 1);
    }

    function testCanFundPot() public mintAndApproveTokens {
        vm.startPrank(user);
        contest = ContestManager(conMan).createContest(players, rewards, IERC20(ERC20Mock(weth)), 4);
        ContestManager(conMan).fundContest(0);
        vm.stopPrank();
        assertEq(ERC20Mock(weth).balanceOf(contest), 4);
    }
}
