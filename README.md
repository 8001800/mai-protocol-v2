# MAI PROTOCOL V2 - PERPETUAL CONTRACT

[![Build Status](https://travis-ci.org/mcdexio/mai-protocol-v2.svg?branch=master)](https://travis-ci.org/mcdexio/mai-protocol-v2)
[![Coverage Status](https://coveralls.io/repos/github/mcdexio/mai-protocol-v2/badge.svg?branch=master)](https://coveralls.io/github/mcdexio/mai-protocol-v2?branch=master)

Mai Protocol V2 builds the decentralized Perpetual contracts on Ethereum.

The name Mai comes from two Chinese characters "买" which means buy and "卖" which means sell. Using pinyin (the modern system for transliterating Chinese characters to Latin letters) "买" is spelled Mǎi and "卖" is spelled Mài. Thus, "Mai" means "Buy" and "Sell".

## Key Features

- Isolated margin account management
- Trade & manage the position
- AMM to provide on-chain liquidity & funding rate
- Funding payment between long/short positions
- Validate the users' orders and execute the match result of order book
- Liquidation of the unsafe position
- Insurance fund
- Socialize the liquidation loss
- Global settlement when an emergency to keep the users' assets safe

## Design Details

Check our [documents](https://github.com/mcdexio/documents) to get more information.

## Contracts

### Mainnet

|Contract|Description|Address|
|---|---|---|
|[`Perpetual`](contracts/perpetual/Perpetual.sol)               |Perpetual core logic including margin account, PnL, etc.|[0x220a9f0DD581cbc58fcFb907De0454cBF3777f76](https://etherscan.io/address/0x220a9f0DD581cbc58fcFb907De0454cBF3777f76)|
|[`AMM`](contracts/liquidity/AMM.sol)                           |Automated Market Maker                                  |[0xAAaC8434217575643B2D2aB6f12CE8600C625520](https://etherscan.io/address/0xAAaC8434217575643B2D2aB6f12CE8600C625520)|
|[`Proxy`](contracts/proxy/PerpetualProxy.sol)                  |AMM margin account                                      |[0x05c363D2B9AFc36b070fe2c61711280eDC214678](https://etherscan.io/address/0x05c363D2B9AFc36b070fe2c61711280eDC214678)|
|[`GlobalConfig`](contracts/global/GlobalConfig.sol)            |Common governance parameters                            |[0x71e77Ffbbfd4418ED47981927738b5425c187F64](https://etherscan.io/address/0x71e77Ffbbfd4418ED47981927738b5425c187F64)|
|[`Exchange`](contracts/exchange/Exchange.sol)                  |Orderbook exchange logic                                |[0xbF5c98A4eD00C28957b6e15A01102DC2568D2650](https://etherscan.io/address/0xbF5c98A4eD00C28957b6e15A01102DC2568D2650)|
|[`PriceFeeder`](contracts/oracle/InversedChainlinkAdapter.sol) |Price oracle                                            |[0x9B2D7D7f7b2810Ef2be979fc2ACebe6097d9563A](https://etherscan.io/address/0x9B2D7D7f7b2810Ef2be979fc2ACebe6097d9563A)|
|[`ShareToken`](contracts/token/ShareToken.sol)                 |Share token of the AMM                                  |[0xAe694FB9DCD1E6195519c0056B2aB19380B26FF2](https://etherscan.io/address/0xAe694FB9DCD1E6195519c0056B2aB19380B26FF2)|
|[`ContractReader`](contracts/reader/ContractReader.sol)        |A batch reader in order to reduce calling consumption   |[0x53C9Df248150AD849bD1BadD3C83b0f6cb735052](https://etherscan.io/address/0x53C9Df248150AD849bD1BadD3C83b0f6cb735052)|
  

  



