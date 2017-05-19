# SmartLogin ÐAPP
This repo contains the code of a full Ethereum "web3" application.

## Notes
This application exists for educational purposes only, it is no way made to be used on production systems (though it should be secure, if using an external node and not the browser support).

The web-ui supports 2 modes: full wallet support in a browser (works for mobile clients) and an external provider such as Mist, MetaMask or even a local geth/parity node.

The in-browser support asks for a seed in order to derive its private key and corresponding address. Since any seed is accepted this should be used as a demostration only, the address generated by this **SHOULD NOT BE USED** on the main network. This mode signs the transactions locally and forwards them to an [Infura node](https://infura.io/). 

The contract address present in web-ui/index.html file is my contract's address on the Rinkeby testnet, feel free to use modify it to use your own.

## Structure
The **SmartLogin** folder is a [truffle](http://truffleframework.com/) project containing both the SmartLogin Ethereum contract written in solidity and the nodejs server application that processes the transactions and executes the corresonding command locally.

The **web-ui** folder is a pure HTML/CSS/JS application using [web3](https://github.com/ethereum/web3.js) and some [ethereumJS](https://github.com/ethereumjs) libs: ethereumjs-wallet to handle a simple in-browser wallet and ethereumjs-tx to sign transactions in the browser.

## Get it running
First step is to run a local Ethereum node you can interact with, you can use a testnet or [testrpc](https://github.com/ethereumjs/testrpc) to quickly get it running. The below example assume you have a node running at localhost:8545. Then `npm install` inside the SmartLogin folder to fetch its dependencies.

Next, from the SmartLogin directory, run a truffle console and deploy the contract on the blockchain:
```
> truffle console
truffle(development)> deploy
Using network 'development'.

Running migration: 1_initial_migration.js
  Deploying Migrations...
  Migrations: 0x472d5b3d5840397d3be08911d425ba5231aca7df
Saving successful migration to network...
Saving artifacts...
Running migration: 2_deploy_contracts.js
  Deploying SmartLogin...
  SmartLogin: 0xe9f5ed08a4fd4299688b008359bb855f72c042aa
Saving successful migration to network...
Saving artifacts...

```

You should next approve a few "realm" (that will be commands to be run by the node local server):
```
truffle(development)> SmartLogin.deployed().then(function(s){ sl = s; })
truffle(development)> sl.approve(web3.eth.coinbase, "lock")
```
From that point you have a running contract on the blockchain with your coinbase address allowed to login to the "lock" realm. Now it's time to launch the node server on your local computer, it will respond to LoginSuccessful events of the contract.

Inside the SmartLogin folder run `npm install` to gather dependencies, then run `npm run app` to launch the blockchain listener.

Now, simply update the web-ui/index.html file with the address of your newly deployed contract and start use it! 
