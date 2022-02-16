pragma solidity ^0.8.7;


contract ZSocialDAO {
    constructor() public {

    }

    event ZSocialMessage(string text);

    function sendMessage(string memory text) public {
        emit ZSocialMessage(text);
    }
}
