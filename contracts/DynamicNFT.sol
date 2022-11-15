pragma solidity ^0.6.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DynamicNFT is ERC721, VRFConsumerBase, Ownable {
    using SafeMath for uint256;
    using Strings for string;

    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;
    address public VRFCoordinator;
    // rinkeby: 0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B
    address public LinkToken;
    // rinkeby: 0x01BE23585060835E02B77ef475b0Cc51aA1e0709a

    struct Character {
        string name;
    }

    Character[] public characters;

    mapping(bytes32 => string) requestToCharacterName;
    mapping(bytes32 => address) requestToSender;
    mapping(bytes32 => uint256) requestToTokenId;

    constructor(
        address _VRFCoordinator,
        address _LinkToken,
        bytes32 _keyhash
    )
        public
        VRFConsumerBase(_VRFCoordinator, _LinkToken)
        ERC721("DynamicNFT", "DNFT")
    {
        VRFCoordinator = _VRFCoordinator;
        LinkToken = _LinkToken;
        keyHash = _keyhash;
        fee = 0.1 * 10**18; // 0.1 LINK
        _setTokenURI(0, 'https://ipfs.io/ipfs/QmPPTx3FbuRfNjpxS6kDFgqxV5XFRDsnSS5FDdFDWMJMX7?filename=dnft.json');
    }

    function requestNewRandomCharacter(string memory name)
        public
        returns (bytes32)
    {
        require(
            LINK.balanceOf(address(this)) >= fee,
            "Not enough LINK - fill contract with faucet"
        );
        bytes32 requestId = requestRandomness(keyHash, fee);
        requestToCharacterName[requestId] = name;
        requestToSender[requestId] = msg.sender;
        return requestId;
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        return tokenURI(tokenId);
    }

    function setTokenURI(uint256 tokenId, string memory _tokenURI) public {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: transfer caller is not owner nor approved"
        );
        _setTokenURI(tokenId, _tokenURI);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomNumber)
        internal
        override
    {
        uint256 newId = characters.length;
       
        _safeMint(requestToSender[requestId], newId);
    }




}
