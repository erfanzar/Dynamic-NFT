//     string[] uri = [
//         // "https://halaholidays.com/nft/dnft.json",
//
//         "https://ipfs.io/ipfs/Qmb9xxpPWtWVPsMfGtDUhEWmb7UzpSC6cLAFPwCobzk4fc?filename=dnft-1.json",
//         "https://ipfs.io/ipfs/QmZ8wTAyezmWeBeA7H69mHoojWYFy8S2871uwrUtzSysDV?filename=dnft-2.json",
//         "https://ipfs.io/ipfs/QmZaNjYJTV2nHkUmvArY6FZr8qy3d7cyjkpHgYWgenipEv?filename=dnft-3.json",
//         "https://ipfs.io/ipfs/QmdDTuyLPFbnAfBipKmHzvucrwxtAhjV7WU1KpRZFR4U6r?filename=dnft-4.json",
//         "https://ipfs.io/ipfs/QmTvBSytyiBwjkTE9PyKEE8tA89xnkYqTER9djHCfh8Eh7?filename=dnft-5.json",
//         "https://ipfs.io/ipfs/Qmc8Fi29CccLvLXeCcKaFo7Ldcw2VjDLgY845FKVPMBeFK?filename=dnft-6.json",
//         "https://ipfs.io/ipfs/QmX5pEkagzkBJtsffJuitAqKkLhcXNGM2gC73eiKYhZ8qo?filename=dnft-7.json",
//         "https://ipfs.io/ipfs/Qmc2mweVq8bAUBEXPE2LaNLvGJ8gkqaRxumdDXg8L7PsRR?filename=dnft-8.json",
//         "https://ipfs.io/ipfs/QmRa2DSzMCPvSJjQD6s98SGRfoJo1VjPjhsvn5UVFGBPtQ?filename=dnft-9.json",
//         "https://ipfs.io/ipfs/QmR3pcNbjgq6i8JMWHEfRm4v33Z962a6Kx9ajNtPzKEzcE?filename=dnft-10.json",
//         "https://ipfs.io/ipfs/QmYNVa1AnE8uYddfagA4wu8FA5WdJxVjzxS9XTiBBQYoty?filename=dnft-11.json",
//         "https://ipfs.io/ipfs/QmTbdvQYA17zTxGHHWUrYLTBhowkqSdCxnGGX8L6g5JpeP?filename=dnft-12.json",
//         "https://ipfs.io/ipfs/QmSZF5pHa7Haf9m96EL4nAx2Y98wDusZEdhrbR8Vygc3H3?filename=dnft-13.json",
//         "https://ipfs.io/ipfs/QmYebVo3jQgrAMorYF8zhzpFQjSXaDjeHUCtWA4AJFuWyH?filename=dnft-14.json"
//     ];

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
// import "../node_modules/OpenZeppelin/contracts/token/ERC721/ERC721.sol";
// import "../node_modules/OpenZeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
// import "@chainlink/contracts/src/v0.8/KeeperCompatible.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract DynamicNFT is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 public interval;
    uint256 public lastTimeStamp;

    event TokensUpdated(uint marketTrend);

    constructor() ERC721("DynamicNFT", "ALMD") {}

    AggregatorV3Interface public priceFeed;
    int256 public currentPrice;

    string[] uris = [
        "https://ipfs.io/ipfs/Qmc2mweVq8bAUBEXPE2LaNLvGJ8gkqaRxumdDXg8L7PsRR?filename=dnft-8.json",
        "https://ipfs.io/ipfs/QmTJdQiXTHJXK1pFt3TyMniAzfWgjFJHvzAoCxQJrnERPM?filename=dnft-0.json"
    ];

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        string memory DEFAULTVAL = uris[0];
        _setTokenURI(tokenId, DEFAULTVAL);
    }

    

    function setTokenURI (uint level) public onlyOwner{
        for (uint i=0 ; i<_tokenIdCounter.current();i++){
            _setTokenURI(i, uris[level]);
        }
        emit TokensUpdated(level);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
