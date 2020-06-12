pragma solidity 0.5.15;
pragma experimental ABIEncoderV2; // to enable structure-type parameter

import "../lib/LibTypes.sol";
import "../interface/IPerpetual.sol";

contract ContractReader {
    struct GovParams {
        LibTypes.PerpGovernanceConfig perpGovernanceConfig;
        LibTypes.AMMGovernanceConfig ammGovernanceConfig;
        address amm; // AMM contract address
        address poolAccount; // AMM account address
    }

    struct PerpetualStorage {
        address collateralTokenAddress;
        address shareTokenAddress;
        uint256 totalSize;
        int256 insuranceFundBalance;
        int256 longSocialLossPerContract;
        int256 shortSocialLossPerContract;
        bool isEmergency;
        bool isGlobalSettled;
        uint256 globalSettlePrice;
        LibTypes.FundingState fundingParams;
    }

    struct AccountStorage {
        LibTypes.MarginAccount margin;
    }

    function getGovParams(address perpetualAddress) public view returns (GovParams memory params) {
        IPerpetual perpetual = IPerpetual(perpetualAddress);
        params.perpGovernanceConfig = perpetual.getGovernance();
        params.ammGovernanceConfig = perpetual.amm().getGovernance();
        params.amm = address(perpetual.amm());
        params.poolAccount = address(perpetual.amm().perpetualProxy());
    }

    function getPerpetualStorage(address perpetualAddress) public view returns (PerpetualStorage memory params) {
        IPerpetual perpetual = IPerpetual(perpetualAddress);
        params.collateralTokenAddress = address(perpetual.collateral());
        params.shareTokenAddress = address(perpetual.amm().shareTokenAddress());

        params.totalSize = perpetual.totalSize(LibTypes.Side.LONG);
        params.longSocialLossPerContract = perpetual.socialLossPerContract(LibTypes.Side.LONG);
        params.shortSocialLossPerContract = perpetual.socialLossPerContract(LibTypes.Side.SHORT);
        params.insuranceFundBalance = perpetual.insuranceFundBalance();

        params.isEmergency = perpetual.status() == LibTypes.Status.EMERGENCY;
        params.isGlobalSettled = perpetual.status() == LibTypes.Status.SETTLED;
        params.globalSettlePrice = perpetual.settlementPrice();

        params.fundingParams = perpetual.amm().lastFundingState();
    }

    function getAccountStorage(address perpetualAddress, address trader)
        public
        view
        returns (AccountStorage memory params)
    {
        IPerpetual perpetual = IPerpetual(perpetualAddress);
        params.margin = perpetual.getMarginAccount(trader);
    }

    /////////////////////////////////////////////////////
    // backward compatibility - beta

    function getBetaAccountStorage(address perpetualAddress, address trader)
        public
        view
        returns (AccountStorage memory params)
    {
        IBetaPerpetual perpetual = IBetaPerpetual(perpetualAddress);
        IBetaPerpetual.BetaCollateralAccount memory collateral = perpetual.getCashBalance(trader);
        IBetaPerpetual.BetaPositionAccount memory position = perpetual.getPosition(trader);

        params.margin.side = position.side;
        params.margin.size = position.size;
        params.margin.entryValue = position.entryValue;
        params.margin.entrySocialLoss = position.entrySocialLoss;
        params.margin.entryFundingLoss = position.entryFundingLoss;
        params.margin.cashBalance = collateral.balance;
    }
}

interface IBetaPerpetual {
    struct BetaCollateralAccount {
        int256 balance;
        int256 appliedBalance;
        uint256 appliedHeight;
    }

    struct BetaPositionAccount {
        LibTypes.Side side;
        uint256 size;
        uint256 entryValue;
        int256 entrySocialLoss;
        int256 entryFundingLoss;
    }

    function getCashBalance(address guy) external view returns (BetaCollateralAccount memory);
    function getPosition(address guy) external view returns (BetaPositionAccount memory);
}
