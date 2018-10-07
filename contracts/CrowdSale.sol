pragma solidity ^ 0.4.25;

contract CrowdSale {
    uint256 public startTime; // #A
    uint256 public endTime; // #B
    uint256 public weiTokenPrice; // #C
    uint256 public weiInvestmentObjective; // #D

    mapping(address => uint256) public investmentAmountOf; // #E

    uint256 public investmentReceived; // #F
    uint256 public investmentRefunded; // #G

    bool public isFinalized; // #H
    bool public isRefundingAllowed; // #I
    address public owner; // #J

    SimpleCoin public crowdSaleToken; // #K

    constructor(uint256 _startTime, uint256 _endTime,
        uint256 _weiTokenPrice, uint256 _etherInvestmentObjective) public {
        require(_startTime >= now); //#A1
        require(_endTime >= _startTime); //#A1
        require(_weiTokenPrice != 0); //#A1
        require(_etherInvestmentObjective != 0); //#A1

        startTime = _startTime; //#B1
        endTime = _endTime; //#B1
        weiTokenPrice = _weiTokenPrice; //#B1
        weiInvestmentObjective = _etherInvestmentObjective * 1000000000000000000; //#B1

        crowdsaleToken = new SimpleCoin(0); //#C1
        isFinalized = false;
        isRefundingAllowed = false;
        owner = msg.sender; //#D1
    }
}

// #A start time, in unix epoch, of the crowdsale funding stage
// #B end time, in unix epoch, of the crowdsale funding stage
// #C price of the token being sold
// #D minimum investment objective, which defines if the crowdsale is successful
// #E amount of ether received by each investor
// #F total ether received from the investors
// #G total ether refunded to the investors
// #H flag indicating if the contract has been finalized
// #I flag indicating whether refunding is allowed
// #J account of the crowdsale contract owner
// #K instance of the contract of the token being sold: we will use SimpleCoin for the moment

// #A1 Validate input configurations
// #B1 Set input configurations into state variables
// #C1 Instantiate the contract of the token being sold in the crowdsale
// #D1 Set the contract owner, as seen in SimpleCoin