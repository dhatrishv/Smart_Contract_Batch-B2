// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/*
  Rock-Paper-Scissors (Player Advantage + Streak Bonuses)
  - Player win chance boosted to ~48%
  - Streak rewards:
      3 wins in a row → +50% reward
      5 wins in a row → 2x reward
*/

contract RPSgame {
    address public owner;
    uint256 public baseReward = 0.001 ether;
    uint256 private nonce;

    mapping(address => uint256) public winStreak;

    event Played(address indexed player, uint256 playerMove, uint256 computerMove, uint256 result, uint256 streak);
    event Funded(address indexed from, uint256 amount);
    event Withdraw(address indexed to, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor() {
        owner = msg.sender;
        nonce = 1;
    }

    function play(uint256 _playerMove) external returns (uint256) {
        require(_playerMove <= 2, "Invalid move");

        // Random number 0–99
        uint256 rand = uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp,
                    block.prevrandao,
                    msg.sender,
                    address(this).balance,
                    nonce
                )
            )
        ) % 100;

        unchecked { ++nonce; }

        uint256 computerMove;

        // ⭐ PLAYER ADVANTAGE MODE ⭐
        // 48% chance → computer plays a losing move
        if (rand < 48) {
            // Make the player win
            if (_playerMove == 0) computerMove = 2;      // Rock beats Scissors
            else if (_playerMove == 1) computerMove = 0; // Paper beats Rock
            else computerMove = 1;                       // Scissors beats Paper
        }
        else {
            // Regular random computer move
            computerMove = uint256(
                keccak256(abi.encodePacked(block.timestamp, msg.sender, nonce))
            ) % 3;
        }

        uint256 result;
        uint256 rewardToSend = baseReward;

        // Game results
        if (_playerMove == computerMove) {
            result = 0;
            winStreak[msg.sender] = 0;
        } else if (
            (_playerMove == 0 && computerMove == 2) ||
            (_playerMove == 1 && computerMove == 0) ||
            (_playerMove == 2 && computerMove == 1)
        ) {
            // PLAYER WINS
            result = 1;

            // Update streak
            winStreak[msg.sender]++;

            // ⭐ BONUS REWARDS ⭐
            if (winStreak[msg.sender] == 3) {
                rewardToSend = (baseReward * 150) / 100; // +50%
            } 
            else if (winStreak[msg.sender] >= 5) {
                rewardToSend = baseReward * 2; // 2x reward
            }

            // Try sending reward (never reverts)
            if (address(this).balance >= rewardToSend) {
                (bool sent, ) = payable(msg.sender).call{value: rewardToSend}("");
                if (!sent) {
                    // don't revert
                }
            }
        } else {
            // COMPUTER WINS
            result = 2;
            winStreak[msg.sender] = 0;
        }

        emit Played(msg.sender, _playerMove, computerMove, result, winStreak[msg.sender]);

        return result;
    }

    function fund() external payable {
        require(msg.value > 0, "Send ETH");
        emit Funded(msg.sender, msg.value);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function withdraw(uint256 amount) external onlyOwner {
        require(amount <= address(this).balance, "Not enough balance");
        (bool sent, ) = payable(owner).call{value: amount}("");
        require(sent, "Withdraw failed");
        emit Withdraw(owner, amount);
    }

    receive() external payable {
        emit Funded(msg.sender, msg.value);
    }

    fallback() external payable {
        if (msg.value > 0) emit Funded(msg.sender, msg.value);
    }
}
