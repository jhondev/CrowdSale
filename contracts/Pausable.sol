pragma solidity ^0.4.25;
import "./Ownable.sol";

contract Pausable is Ownable {
    bool public paused = false; //#A

    modifier whenNotPaused() {
        //#B
        require(!paused);
        _;
    }

    modifier whenPaused() {
        //#B
        require(paused);
        _;
    }

    function pause() public onlyOwner whenNotPaused {
        //#C
        paused = true;
    }

    function unpause() public onlyOwner whenPaused {
        //#C
        paused = false;
    }
}
