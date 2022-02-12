// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract Gambling {

    function testContractLoad() public view returns (uint) {
        uint256 input = uint256(500000000000000000);
        uint amount = input * LEVEL_0_to_AVAX / (10**18);
        return amount;
    }

    function getAvaxBalance() public view returns (uint) {
        return address(this).balance;
    }


}
