// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract ZelantDAO is ERC1155 {
    uint256 public constant LEVEL_0 = 0;
    uint256 public constant LEVEL_1 = 1;
    uint256 public constant LEVEL_2 = 2;
    uint256 public constant LEVEL_3 = 3;
    uint256 public constant LEVEL_4 = 4;

    uint256 public constant LEVEL_0_to_AVAX = 1000; // 10 LEVEL_0 to each 1 AVAX

    constructor() public ERC1155("https://zelantsoft.com/api/item/{id}.json") {
        _mint(address(this), LEVEL_0, 10**18, "");
        _mint(address(this), LEVEL_1, 10**9, "");
        _mint(address(this), LEVEL_2, 10**3, "");
        _mint(address(this), LEVEL_3, 10**2, "");
        _mint(address(this), LEVEL_4, 10**1, "");

        //setApprovalForAll(address(this), true);
    }

    function getContractAddress() public view returns (address) {
        return address(this);
    }



    function testContractLoad() public view returns (uint) {
        uint256 input = uint256(500000000000000000);
        uint amount = input * LEVEL_0_to_AVAX / (10**18);
        return amount;
    }

    function getAvaxBalance() public view returns (uint) {
        return address(this).balance;
    }

    event SentViaCall(address, uint);
    function sendViaCall(address payable _to, uint amount) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, bytes memory data) = _to.call{value: amount}("");
        require(sent, "Failed to send Ether");
        emit SentViaCall(_to, amount);
    }

    function redeemLEVEL0ForAvax(uint amount, address payable _to) public payable returns (uint) {
        if(_to == address(0)){
            _to = payable(msg.sender);
        }
        _safeTransferFrom(msg.sender, address(this), LEVEL_0, amount, "");
        uint avaxAmount = amount * 10**18 / LEVEL_0_to_AVAX;
        sendViaCall(_to, avaxAmount);
        return avaxAmount;

    }

    // function getLEVEL0(uint amount) public {
    //     //setApprovalForAll(msg.sender, true);
    //     _safeTransferFrom(address(this), msg.sender, LEVEL_0, amount, "");
    // }

    event FallbackReceived(address, uint);

    fallback() external payable {
        emit FallbackReceived(msg.sender, msg.value);
    }

    event Received(address, address, uint);

    event LEVEL0SoldForAvax(address, address, uint, uint);

    event InitialFundingReceived();

    receive() external payable {
        emit Received(address(this), msg.sender, msg.value);

        uint amount = msg.value * LEVEL_0_to_AVAX / (10**18);

        if(address(this).balance > 0){
            _safeTransferFrom(address(this), msg.sender, LEVEL_0, amount, "");
            emit LEVEL0SoldForAvax(address(this), msg.sender, LEVEL_0, amount);
        }
        else
        {
            emit InitialFundingReceived();
        }
    }

}
// 0xc31E21f97043b0538Ffc948c27AeD80866344e9e
