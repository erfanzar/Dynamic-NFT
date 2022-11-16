const DN = artifacts.require('DynamicNFT')
const LINK_TOKEN = '0x326C977E6efc84E512bB9C30f76E30c160eD06FB'
const VRF_COORDINATOR = '0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D'
const KEY_HASH = '0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15'

module.exports = async (deployer, network, [defaultAccount]) => {
    // deployer.deploy(DN,VRF_COORDINATOR,LINK_TOKEN,KEY_HASH)
    deployer.deploy(DN)
    let dnd = await DN.deployed()
}