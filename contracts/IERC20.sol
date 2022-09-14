// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ERC20 is IERC20 {
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf; //address to amount
    //holder gives permission to spender to have some certain amount
    mapping(address => mapping(address => uint256)) public allowance;
    string public name = "Casher";
    string public symbol = "Cash";
    uint8 public decimals = 18;

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

    function approve(address spender, uint256 amount)
        external
        override
        returns (bool)
    {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address receipent,
        uint256 amount
    ) external override returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[receipent] += amount;
        emit Transfer(sender, receipent, amount);
        return true;
    }

    function mint(uint256 amount) external override {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint256 amount) external override {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
