const networkConfig = {
    31337: {
        name: "localhost",
    },
    5: {
        name: "goerli",
    },
};

const developmentChains = ["hardhat", "localhost"];

// Next.js The Graph
const frontEndContractsFile = "../portfolio-snake-game-dapp-nextjs/constants/contractAddresses.json";
const frontEndAbiLocation = "../portfolio-snake-game-dapp-nextjs/constants/";

module.exports = {
    networkConfig,
    developmentChains,
    frontEndContractsFile,
    frontEndAbiLocation,
};
