// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

///////////////
//  Imports  //
///////////////
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//////////////
//  Errors  //
//////////////
error Token__ReceivedEthTransferReverted();
error Token__InvalidFunctionCall();

////////////////////
// Smart Contract //
////////////////////

/**
 * @title Token contract
 * @author Dariusz Setlak, OpenZeppelin
 * @dev Smart contract based on Ethereum ERC-20 token standard, created using OpenZeppelin Wizard. Contract inherits
 * all ERC-20 token standard functions from OpenZeppelin library contracts.
 *
 * `Token` contract inherits `Ownable` contract from OpenZeppelin library, which sets `deployer` as contract `owner`.
 * This means, that ONLY owner will be authorized to call some sensitive contract functions like `mint` or `burn`,
 * which can be obtained by using `onlyOwner` modifier for these functions.
 *
 * `Token` contract is used for creation of two ERC-20 game utility tokens contract: `Snake Token [SNAKE]` and `Fruit Token [FRUIT]`.
 * Both tokens have 0 decimals, what is obtained by override function `decimals`. Both tokens are also burnable and mintable, but
 * this functionalities are restricted to use only for contract `owner`, which in our game is `SnakeGame` contract.
 *
 * Smart contract functions:
 * Overriden functions: mint, decimals
 * Other functions: receive, fallback
 */
contract Token is ERC20, ERC20Burnable, Ownable {
    ///////////////////
    //  Constructor  //
    ///////////////////

    /**
     * @dev `Token` contract constructor passes given parameters to OpenZeppelin library ERC20 constructor,
     * which use them to construct a standard ERC-20 token.
     * @param name token name
     * @param symbol token symbol
     */
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {}

    /////////////////////////
    // Overriden Functions //
    /////////////////////////

    /**
     * @dev Function `mint` allows ONLY `owner` mint new tokens (modifier onlyOwner used).
     * Function calls `_mint` function from standard OpenZeppelin library ERC20.
     */
    function mint(address _to, uint256 _amount) external onlyOwner {
        _mint(_to, _amount);
    }

    /**
     * @dev Function `decimals` override OpenZeppelin ERC20 contract function and returns new token decimal value `0`,
     * instead of default and standard value `18`. This is intended and needed in the game and make our game utility
     * tokens easier to use.
     * @return Number of token decimals.
     */
    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    /////////////////////
    // Other Functions //
    /////////////////////

    /**
     * @notice Receive ETH
     * @dev Functoin executes if unintended ETH transfer received.
     * This contract doesn't allows to receive ETH transfers, thererfore `receive` function
     * reverts all unintended ETH transfers.
     */
    receive() external payable {
        revert Token__ReceivedEthTransferReverted();
    }

    /**
     * @notice Fallback function
     * @dev Function executes if none of the contract functions match the intended function calls.
     * Function reverts transaction if called function is not found in the contract.
     */
    fallback() external payable {
        revert Token__InvalidFunctionCall();
    }
}
