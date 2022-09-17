// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @author INTERFACES
 * INTERFACES can't decalare constructor.
 * INTERFACES cant declare state variable.
 * INTERFACES function must be external.
 * INTERFACES cant have functions Implemented.
 *
 * @author  "We can always add state variables (and a constructor) in the contract which inherits the interface." --
 * not the interface itself, but the CONTRACT which "uses" (inherits) the interface.
 *
 * @author  ERC20 VS IERC20
 * The IERC20.sol is a interface contract, all in this file are standard as defined in the EIP.
 * As for ERC20.sol,
 * it is an implementation of the IERC20.sol, you can define all your token logic in it.
 *
 * @author why do we use allowanse function?
 * 
 * @author functions
-   1-total supply = AMount of the ERC20 token.
-   2-balanceOf = total balance of the contract
-   3-transfer= holder of the token will transfer to the recipent and fill amount.
-   4-Approve= holder can use `approve` function instead of `transfer`. in which he will
-   be approving `spender address` and its `amount` as well.
-   5-allowance = is the fuction which tells how much can `spender` can spend.
-   6- Transferfrom- once the `spender` has the approval he can call `transferFrom` function.
-   in which he will be sending money from the `sender` account(sender is the person who approve the `spender`)
-   its `spender` send the the money to `receipet` from `sender's accoount`while calling `transferFrom`.
-
-
-   @author
-   When we `burn` supply gets reduced and when we mint supply gets increased.
 *
 */

contract ERC20 is IERC20 {
    uint256 public override totalSupply;
    mapping(address => uint256) public override balanceOf; //address to amount
    //holder gives permission to spender to have some certain amount
    mapping(address => mapping(address => uint256)) public override allowance;
    string public name = "Casher";
    string public symbol = "Cash";
    uint8 public decimals = 18;

    constructor(
        uint256 IntialSupply,
        string memory tokenName,
        string memory tokenSymbol
    ) {
        totalSupply = IntialSupply * 10**uint256(decimals);
        name = tokenName;
        symbol = tokenSymbol;
    }

    // This function will transfer tokens from `msg.sender` to `receipent`
    //once the token has been transfered we will update `balanceOf`
    function transfer(address receipent, uint256 amount)
        external
        override
        returns (bool)
    {
        // balanceOf[msg.sender]=balanceOf[msg.sender]-amount
        balanceOf[msg.sender] -= amount;
        balanceOf[receipent] += amount;
        emit Transfer(msg.sender, receipent, amount);
        return true;
    }

    //this function will be used by `msg.sender` to approve funds to spender.
    function approve(address spender, uint256 amount)
        external
        override
        returns (bool)
    {
        allowance[msg.sender][spender] = amount; //[msg.sender][spender address]= amount
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    //this function will be used by spender
    function transferFrom(
        address sender,
        address receipent,
        uint256 amount
    ) external override returns (bool) {
        allowance[sender][msg.sender] -= amount; //[sender address][msg.sender]
        balanceOf[sender] -= amount;
        balanceOf[receipent] += amount;
        emit Transfer(sender, receipent, amount);
        return true;
    }

    //function will be used for generate new tokens
    function mint(uint256 amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    //will be used for decrease the token numbers
    function burn(uint256 amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
