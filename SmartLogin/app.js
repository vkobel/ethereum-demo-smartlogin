// Import libraries we need.
const Web3 = require('web3');
const Contract = require('truffle-contract')
const smartlogin_artifacts = require('./build/contracts/SmartLogin.json')
var SmartLogin = Contract(smartlogin_artifacts);

var exec = require('child_process').exec;

var App = {
    web3: new Web3(new Web3.providers.HttpProvider("http://localhost:8545")),
  
    start: function() {
        var self = this;

        SmartLogin.setProvider(self.web3.currentProvider);
        
        SmartLogin.deployed()
        .then(function(inst){ return inst; })
        .then(function(sl){
            sl.SuccessfulLogin().watch(function(err, log){
                
                exec(log.args._realm, function(err, stdout, stderr){
                    console.log(err, stdout, stderr)
                });

            });
        });
    },
};

App.start();

