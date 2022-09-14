// contracts/OurToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @dev  allowance
 *  allowance- allow a third party to have the right to carry out a transaction of a certain amount of our tokens,
 * which are associated with our address.
 * All this without giving the private key of your address.
 */

contract OurToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("OurToken", "OT") {
        _mint(msg.sender, initialSupply);
    }
}
