pragma solidity ^0.4.25;
import "./Ownable.sol";

contract Destructible is Ownable {

    function Destructible() payable public { }

    function destroyAndSend(address _recipient) onlyOwner public {
        selfdestruct(_recipient);
    }
}