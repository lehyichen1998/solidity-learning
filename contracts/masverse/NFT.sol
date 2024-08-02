// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721, Ownable {
    uint256 private _nextTokenId;
    string private _baseTokenURI;
    uint256 public MAX_SUPPLY;
    bool public PaxLimit;

    mapping(address owner => uint256[]) private nftOwned;

    constructor(
        address initialOwner,
        uint256 maxSupply,
        string memory name,
        string memory symbol,
        bool limit,
        string memory baseURI
    ) ERC721(name, symbol) Ownable(initialOwner) {
        _baseTokenURI = baseURI;
        MAX_SUPPLY = maxSupply;
        PaxLimit = limit;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
    }

    function mint(address to, uint256 id) public onlyOwner returns (uint) {
        if (MAX_SUPPLY != 0) {
            require(_nextTokenId < MAX_SUPPLY, "Max supply reached");
        }
        if (PaxLimit) {
            require(balanceOf(to) == 0, "Max Mint per wallet reached");
        }
        _nextTokenId++;
        _safeMint(to, id);
        nftOwned[to].push(id);
        return id;
    }

    function batchMint(
        address[] memory to,
        uint256[] memory id
    ) public onlyOwner returns (uint[] memory) {
        uint256[] memory mintedIds = new uint256[](to.length);
        for (uint256 i = 0; i < to.length; i++) {
            if (MAX_SUPPLY != 0) {
                require(_nextTokenId < MAX_SUPPLY, "Max supply reached");
            }
            if (PaxLimit) {
                require(balanceOf(to[i]) == 0, "Max Mint per wallet reached");
            }
            _nextTokenId++;
            _safeMint(to[i], id[i]);
            nftOwned[to[i]].push(id[i]);
            mintedIds[i] = id[i]; // Store the minted ID
        }
        return mintedIds;
    }

    struct TokenInfo {
        uint256 tokenId;
        string tokenURI;
    }

    function getNFTid(address owner) public view returns (TokenInfo[] memory) {
        uint256[] memory tokenIds = nftOwned[owner];
        TokenInfo[] memory tokenInfos = new TokenInfo[](tokenIds.length);
        for (uint256 i = 0; i < tokenIds.length; i++) {
            tokenInfos[i] = TokenInfo({
                tokenId: tokenIds[i],
                tokenURI: tokenURI(tokenIds[i])
            });
        }
        return tokenInfos;
    }
}