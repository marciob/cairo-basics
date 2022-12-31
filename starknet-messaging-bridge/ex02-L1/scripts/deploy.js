const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });
require("@nomiclabs/hardhat-etherscan");

async function main() {
  const receiveMessageFromL2 = await ethers.getContractFactory(
    "ReceiveMessageFromL2"
  );
  // deploy the contract
  const deployedReceiveMessageFromL2 = await receiveMessageFromL2.deploy();

  await deployedReceiveMessageFromL2.deployed();

  // print the address of the deployed contract
  console.log("Verify Contract Address:", deployedReceiveMessageFromL2.address);

  console.log("Waiting for Etherscan verification.....");
  // Wait for etherscan to notice that the contract has been deployed
  await sleep(30000);

  // Verify the contract after deploying
  await hre.run("verify:verify", {
    address: deployedReceiveMessageFromL2.address,
    constructorArguments: [],
  });
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

//npx hardhat compile
//npx hardhat run scripts/deploy.js --network goerli
