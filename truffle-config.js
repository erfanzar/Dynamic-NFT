const HDWalletProvider = require('@truffle/hdwallet-provider')
require('dotenv').config()

module.exports = {
    networks: {
        rinkeby: {
            provider: () => {
                return new HDWalletProvider(process.env.MNEMONIC, process.env.RINKEBY_RPC_URL)
            },
            network_id: '4',
            skipDryRun: true,
        },
        mainnet: {
            provider: () => {
                return new HDWalletProvider(process.env.MAINNET_MNEMONIC, process.env.MAINNET_RPC_URL)
            },
            network_id: '1',
            skipDryRun: true,
        },
        goerli: {
            provider: () => new HDWalletProvider(process.env.MNEMONIC, 'https://goerli.infura.io/v3/' + process.env.INFURA_API_KEY),
            network_id: '5',
            // skipDryRun: true,
            gas: 4465030
        },
        matic: {
            provider: () => new HDWalletProvider(process.env.MNEMONIC,  `https://rpc-mumbai.maticvigil.com` + process.env.PROJECT_ID),
            network_id: 80001,
            confirmations: 2,
            timeoutBlocks: 200,
            skipDryRun: true
        },
    },
    compilers: {
        solc: {
            version: '0.6.6',
        },
    },
    api_keys: {
        etherscan: process.env.ETHERSCAN_API_KEY
    },
    plugins: [
        'truffle-plugin-verify'
    ]
}
