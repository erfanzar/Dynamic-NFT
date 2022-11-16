// pragma solidity ^0.6.6;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// contract DynamicNFT is ERC721, VRFConsumerBase, Ownable {
//     using SafeMath for uint256;
//     using Strings for string;

//     bytes32 internal keyHash;
//     uint256 internal fee;
//     uint256 public randomResult;
//     address public VRFCoordinator;
//     // rinkeby: 0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B
//     address public LinkToken;
//     uint256 public decoy;
//     // rinkeby: 0x01BE23585060835E02B77ef475b0Cc51aA1e0709a

//     struct Character {
//         string name;
//     }

//     Character[] public characters;

//     mapping(bytes32 => string) requestToCharacterName;
//     mapping(bytes32 => address) requestToSender;
//     mapping(bytes32 => uint256) requestToTokenId;

//     constructor(
//         address _VRFCoordinator,
//         address _LinkToken,
//         bytes32 _keyhash
//     )
//         public
//         VRFConsumerBase(_VRFCoordinator, _LinkToken)
//         ERC721("DynamicNFT", "DNFT")
//     {
//         VRFCoordinator = _VRFCoordinator;
//         LinkToken = _LinkToken;
//         keyHash = _keyhash;
//         fee = 0.1 * 10**18; // 0.1 LINK
//         decoy = 0;
//         _setTokenURI(decoy, 'https://ipfs.io/ipfs/QmPPTx3FbuRfNjpxS6kDFgqxV5XFRDsnSS5FDdFDWMJMX7?filename=dnft.json');
//     }

//     function requestNewRandomCharacter(string memory name)
//         public
//         returns (bytes32)
//     {
//         require(
//             LINK.balanceOf(address(this)) >= fee,
//             "Not enough LINK - fill contract with faucet"
//         );
//         bytes32 requestId = requestRandomness(keyHash, fee);
//         requestToCharacterName[requestId] = name;
//         requestToSender[requestId] = msg.sender;
//         return requestId;
//     }
//     struct s{
//         uint256 a;
//     }
//     s[] public trashcan;

//     function getTokenURI(uint256 tokenId) public view returns (string memory) {
//         return tokenURI(tokenId);
//     }

//     function setTokenURI(uint256 tokenId, string memory _tokenURI) public {
//         require(
//             _isApprovedOrOwner(_msgSender(), tokenId),
//             "ERC721: transfer caller is not owner nor approved"
//         );
//         _setTokenURI(tokenId, _tokenURI);
//     }

//     function fulfillRandomness(bytes32 requestId, uint256 randomNumber)
//         internal
//         override
//     {
//         uint256 newId = characters.length;
//         uint256 can = randomNumber;
//         trashcan.push(
//             s(
//                 can
//             )

//         );

//         _safeMint(requestToSender[requestId], newId);
//     }

// }

pragma solidity ^0.6.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract DynamicNFT is ERC721{
    using SafeMath for uint256;
    using Strings for string;

    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;
    address public VRFCoordinator;

    address public LinkToken;
 

    struct Character {
        string name;
    }

    Character[] public characters;

    string[] uri = [
        'https://ipfs.io/ipfs/QmTJdQiXTHJXK1pFt3TyMniAzfWgjFJHvzAoCxQJrnERPM?filename=dnft-0.json',
        'https://ipfs.io/ipfs/Qmb9xxpPWtWVPsMfGtDUhEWmb7UzpSC6cLAFPwCobzk4fc?filename=dnft-1.json',
        'https://ipfs.io/ipfs/QmZ8wTAyezmWeBeA7H69mHoojWYFy8S2871uwrUtzSysDV?filename=dnft-2.json',
        'https://ipfs.io/ipfs/QmZaNjYJTV2nHkUmvArY6FZr8qy3d7cyjkpHgYWgenipEv?filename=dnft-3.json',
        'https://ipfs.io/ipfs/QmdDTuyLPFbnAfBipKmHzvucrwxtAhjV7WU1KpRZFR4U6r?filename=dnft-4.json',
        'https://ipfs.io/ipfs/QmTvBSytyiBwjkTE9PyKEE8tA89xnkYqTER9djHCfh8Eh7?filename=dnft-5.json',
        'https://ipfs.io/ipfs/Qmc8Fi29CccLvLXeCcKaFo7Ldcw2VjDLgY845FKVPMBeFK?filename=dnft-6.json',
        'https://ipfs.io/ipfs/QmX5pEkagzkBJtsffJuitAqKkLhcXNGM2gC73eiKYhZ8qo?filename=dnft-7.json',
        'https://ipfs.io/ipfs/Qmc2mweVq8bAUBEXPE2LaNLvGJ8gkqaRxumdDXg8L7PsRR?filename=dnft-8.json',
        'https://ipfs.io/ipfs/QmRa2DSzMCPvSJjQD6s98SGRfoJo1VjPjhsvn5UVFGBPtQ?filename=dnft-9.json',
        'https://ipfs.io/ipfs/QmR3pcNbjgq6i8JMWHEfRm4v33Z962a6Kx9ajNtPzKEzcE?filename=dnft-10.json',
        'https://ipfs.io/ipfs/QmYNVa1AnE8uYddfagA4wu8FA5WdJxVjzxS9XTiBBQYoty?filename=dnft-11.json',
        'https://ipfs.io/ipfs/QmTbdvQYA17zTxGHHWUrYLTBhowkqSdCxnGGX8L6g5JpeP?filename=dnft-12.json',
        'https://ipfs.io/ipfs/QmSZF5pHa7Haf9m96EL4nAx2Y98wDusZEdhrbR8Vygc3H3?filename=dnft-13.json',
        'https://ipfs.io/ipfs/QmYebVo3jQgrAMorYF8zhzpFQjSXaDjeHUCtWA4AJFuWyH?filename=dnft-14.json'

    ];

   
    constructor(
        address to,
        uint256 tokenId
    ) public ERC721("DynamicNFT", "D&D"){
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri[0]);
    }   
    

    function baseTokenURI() public view returns (string memory) {
        return uri[0];
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

    function safeMint(address to) public {
        // uint256 tokenId = _tokenIdCounter.current();
        uint256 tokenId = 0;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri[0]);
    }

    function setLevel(uint256 tokenId,uint256 level) public{
        _setTokenURI(tokenId, uri[level]);
    }



    function getNumberOfCharacters() public view returns (uint256) {
        return characters.length;
    }

    function getCharacterOverView(uint256 tokenId)
        public
        view
        returns (
            string memory
        )
    {
        return  characters[tokenId].name;
    }

    

    function sqrt(uint256 x)  internal  pure  returns (uint256 y) {
        uint256 z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
}
