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
        testnet: {
            provider: () => new HDWalletProvider(process.env.MNEMONIC, `https://data-seed-prebsc-1-s1.binance.org:8545`),
            network_id: 97,
            confirmations: 10,
            timeoutBlocks: 200,
            skipDryRun: true
        },
        bsc: {
            provider: () => new HDWalletProvider(process.env.MNEMONIC, `https://bsc-dataseed1.binance.org`),
            network_id: 56,
            confirmations: 10,
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
        etherscan: process.env.ETHERSCAN_API_KEY,
        polygonscan:'aykqawueu2nvj941dqkr6d86kzg5cmj96z',
        bscscan:'y78prxnaft2yv1xwtjefx321evz28h4avw'
    },
    plugins: [
        'truffle-plugin-verify'
    ]
}
