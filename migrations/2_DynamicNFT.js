const DN = artifacts.require('DynamicNFT')
const LINK_TOKEN = '0x326C977E6efc84E512bB9C30f76E30c160eD06FB'
const VRF_COORDINATOR = '0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed'
const KEY_HASH = '0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f'

module.exports = async (deployer, network, [defaultAccount]) => {
    deployer.deploy(DN,VRF_COORDINATOR,LINK_TOKEN,KEY_HASH)
}