pragma solidity ^0.6.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/utils/Strings.sol";
// tks = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB

contract DynamicNFT is ERC721 {
    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;
    address public VRFCoordinator;

    constructor(
        // address _VRFCoordinator,
        // address _LinkToken,
        bytes32 _keyhash
    )
        public
        
        ERC721("DynamicNFT", "DNFT")
    {
        // VRFCoordinator = _VRFCoordinator;
        keyHash = _keyhash;
        fee = 0.1*10**18;
    }

    struct lvl{
        uint256 level;
    }

    lvl[] public NFTLVL;

    function setTokenURI(uint256 tokenId,string memory _tokenURI) public{
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );
        _setTokenURI(tokenId, _tokenURI);
    }
}
