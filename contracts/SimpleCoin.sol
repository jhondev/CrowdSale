pragma solidity ^0.4.25;


contract SimpleCoin {

    mapping(address => uint256) public coinBalance;
    mapping(address => mapping(address => uint256)) public allowance;
    mapping (address => bool) public frozenAccount;    
    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event FrozenAccount(address target, bool frozen);

    modifier onlyOwner {
        if (msg.sender != owner) revert();
        _;
    }

    constructor(uint256 _initialSupply) {
        owner = msg.sender;
        mint(owner, _initialSupply);
    }

    function transfer(address _to, uint256 _amount) {
        require(coinBalance[msg.sender] >= _amount);
        require(coinBalance[_to] + _amount >= coinBalance[_to]);
        coinBalance[msg.sender] -= _amount;
        coinBalance[_to] += _amount;
        Transfer(msg.sender, _to, _amount);
    }

    function authorize(address _authorizedAccount, uint256 _allowance) public returns(bool success) {
        allowance[msg.sender][_authorizedAccount] = _allowance;
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _amount) public returns(bool success) {
        require(_to != 0x0); // Prevent transfer to 0x0 address, which is a default address if non-specified explicitly
        require(coinBalance[_from] > _amount);
        require(coinBalance[_to] + _amount >= coinBalance[_to]);
        require(_amount <= allowance[_from][msg.sender]);
        coinBalance[_from] -= _amount;
        coinBalance[_to] += _amount;
        allowance[_from][msg.sender] -= _amount;
        Transfer(_from, _to, _amount);
        return true;
    }


    function mint(address _recipient, uint256 _mintedAmount) onlyOwner public {
        coinBalance[_recipient] += _mintedAmount;
        Transfer(owner, _recipient, _mintedAmount);
    }

    function freezeAccount(address target, bool freeze) onlyOwner public {
        frozenAccount[target] = freeze;
        FrozenAccount(target, freeze);
    }
}