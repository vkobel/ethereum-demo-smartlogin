pragma solidity ^0.4.11;

contract SmartLogin {
	
    mapping (address => mapping(string => bool)) realms;
    address public owner;

    event SuccessfulLogin(address indexed _from, string _realm);
    event FailedLogin(address indexed _from, string _realm);
    event NewRegistration(address indexed _from, string _realm);
    event ApprovedRegistration(address indexed _from, string _realm);

    modifier onlyBy(address _account){
        require(msg.sender == _account);
        _;
    }

    function SmartLogin(){
        owner = msg.sender;
    }

    function changeOwner(address _newOwner) onlyBy(owner) {
        owner = _newOwner;
    }
    
    function register(string _realm) {
        realms[msg.sender][_realm] = false;
        NewRegistration(msg.sender, _realm);
    }

    function approve(address _addr, string _realm) onlyBy(owner) {
        realms[_addr][_realm] = true;
        ApprovedRegistration(_addr, _realm);
    }

    function login(string _realm) returns (bool) {
        if(realms[msg.sender][_realm]){
            SuccessfulLogin(msg.sender, _realm);
            return true;
        }else{
            FailedLogin(msg.sender, _realm);
            return false;
        }
    }

    function CanAccessRealm(address _addr, string _realm) constant returns(bool) {
        return realms[_addr][_realm];
    }
}
