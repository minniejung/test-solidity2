import * as dotenv from "dotenv";
dotenv.config();

import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  defaultNetwork: "kairos",

  networks: {
    hardhat: {},
    localhost: {
      url: "http://127.0.0.1:8545",
    },
    kairos: {
      url: "https://public-en-kairos.node.kaia.io",
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
      chainId: 1001,
    },
  },

  solidity: {
    version: "0.8.28",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
      evmVersion: "paris",
    },
  },

  paths: {
    root: "./",
    sources: "./contracts",
    cache: "./cache",
    artifacts: "./artifacts",
  },
};

export default config;
