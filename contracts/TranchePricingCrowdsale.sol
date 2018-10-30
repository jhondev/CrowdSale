pragma solidity ^0.4.25;

contract TranchePricingCrowdsale is CrowdSale {
    struct Tranche {
        uint256 weiHighLimit;
        uint256 weiTokenPrice;
    }

    mapping(uint256 => Tranche) public trancheStructure;
    uint256 currentTrancheLevel;

    function TranchePricingCrowdsale(
        uint256 _startTime,
        uint256 _endTime,
        uint256 _etherInvestmentObjective
    ) public payable CrowdSale(_startTime, _endTime, 1, _etherInvestmentObjective) {
        //#D
        trancheStructure[0] = Tranche(3000 ether, 0.002 ether); //#E
        trancheStructure[1] = Tranche(10000 ether, 0.003 ether); //#E
        trancheStructure[2] = Tranche(15000 ether, 0.004 ether); //#E
        trancheStructure[3] = Tranche(1000000000 ether, 0.005 ether); //#E

        currentTrancheLevel = 0; //#D
    }

    function calculateNumberOfTokens(uint256 investment) internal returns(
        //#F
        uint256
    ) {
        updateCurrentTrancheAndPrice();
        return investment / weiTokenPrice;
    }

    function updateCurrentTrancheAndPrice() internal {
        //#G
        uint256 i = currentTrancheLevel;

        while (trancheStructure[i].weiHighLimit < investmentReceived) ++i;

        currentTrancheLevel = i;

        weiTokenPrice = trancheStructure[currentTrancheLevel].weiTokenPrice;
    }
}
