// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Market is ERC721URIStorage, Ownable {
    address private creator;

    constructor() ERC721("Footballiga", "FBGA") {
        creator = msg.sender;
    }

    function buy(string memory _tokenURI, uint256 _tokenId) external payable {
        _safeMint(msg.sender, _tokenId);
        _setTokenURI(_tokenId, _tokenURI);

        require(ownerOf(_tokenId) == msg.sender);
        payable(creator).transfer(msg.value);
    }

    function getURI(uint256 _tokenId) public view returns (string memory) {
        return tokenURI(_tokenId);
    }

    function getOwnerToken(uint256 _tokenId) public view returns (address) {
        return ownerOf(_tokenId);
    }

    function transferNft(uint256 _tokenId) external payable {
        address owner = ownerOf(_tokenId);
        _transfer(owner, msg.sender, _tokenId);

        require(ownerOf(_tokenId) == msg.sender);
        payable(owner).transfer(msg.value);
    }
}
