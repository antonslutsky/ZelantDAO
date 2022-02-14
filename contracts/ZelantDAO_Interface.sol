// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract ZelantDAO_Interface is ERC1155 {
    
    ERC1155 CONTRACT_IMPL;

    address admin;

    modifier onlyAdmin {
      require(msg.sender == admin);
      _;
   }

    constructor() public ERC1155("https://zelantsoft.com/api/item/{id}.json") {
        admin = msg.sender;
        setContractImpl(0xc31E21f97043b0538Ffc948c27AeD80866344e9e);
    }
    
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        CONTRACT_IMPL.safeTransferFrom(
         from,
         to,
         id,
         amount,
         data
        );
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual override {
        CONTRACT_IMPL.safeBatchTransferFrom(
         from,
         to,
         ids,
         amounts,
         data
        );
    }
    
    function setContractImpl(address contractImpl) public onlyAdmin {
        if(msg.sender == admin)
        CONTRACT_IMPL = ERC1155(contractImpl);
    }

    function balanceOf(address account, uint256 id) public view virtual override returns (uint256) {
        return CONTRACT_IMPL.balanceOf( account,  id);
    }

    function balanceOfBatch(address[] memory accounts, uint256[] memory ids)
        public
        view
        virtual
        override
        returns (uint256[] memory)
    {
        return CONTRACT_IMPL.balanceOfBatch(accounts, ids);
    }

    function setApprovalForAll(address operator, bool approved) public virtual override {
        CONTRACT_IMPL.setApprovalForAll( operator,  approved);
    }

    
    function isApprovedForAll(address account, address operator) public view virtual override returns (bool) {
        return CONTRACT_IMPL.isApprovedForAll( account,  operator);
    }
}