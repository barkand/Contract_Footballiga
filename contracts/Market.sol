// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <8.13.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Market is ERC721URIStorage, Ownable {
    address public creator;

    constructor() ERC721("Footballiga", "FBGA") {
        creator = msg.sender;
    }

    function buy(string memory _tokenURI, uint256 _itemId) external payable {
        uint256 _tokenId = 14010000 + _itemId;
        string memory newTokenURI = _tokenURI;

        _safeMint(msg.sender, _tokenId);
        _setTokenURI(_tokenId, newTokenURI);

        require(ownerOf(_tokenId) == msg.sender);
        payable(creator).transfer(msg.value);
    }

    function getURI(uint256 _itemId) public view returns (string memory) {
        uint256 _tokenId = 14010000 + _itemId;
        return tokenURI(_tokenId);
    }

    function getOwnerToken(uint256 _itemId) public view returns (address) {
        uint256 _tokenId = 14010000 + _itemId;
        return ownerOf(_tokenId);
    }

    function transferNft(uint256 _itemId) external payable {
        uint256 _tokenId = 14010000 + _itemId;
        address owner = ownerOf(_tokenId);
        _transfer(owner, msg.sender, _tokenId);

        require(ownerOf(_tokenId) == msg.sender);
        payable(owner).transfer(msg.value);
    }
}
