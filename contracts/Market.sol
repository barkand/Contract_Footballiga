// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Market is ERC721URIStorage, Ownable {
    address private creator;
    mapping(uint256 => bool) private buyList;

    constructor() ERC721("Footballiga", "FBGA") {
        creator = msg.sender;
    }

    function getURI(uint256 _tokenId) public view returns (string memory) {
        return tokenURI(_tokenId);
    }

    function getOwnerToken(uint256 _tokenId) public view returns (address) {
        return ownerOf(_tokenId);
    }

    function buy(string calldata _tokenURI, uint256 _tokenId) external payable {
        require(!buyList[_tokenId], "Token URI already exists");

        payable(creator).transfer(msg.value);

        _safeMint(msg.sender, _tokenId);
        _setTokenURI(_tokenId, _tokenURI);

        require(ownerOf(_tokenId) == msg.sender);

        buyList[_tokenId] = true;
    }

    function transferNft(uint256 _tokenId) external payable {
        require(buyList[_tokenId], "Token URI not exists");

        address owner = ownerOf(_tokenId);
        payable(owner).transfer(msg.value);

        _transfer(owner, msg.sender, _tokenId);

        require(ownerOf(_tokenId) == msg.sender);
    }
}
