const { run } = require("hardhat")

const verify = async (contractAddress, args) => {
    console.log("verifyin contract ....")
    try {
        await run("verify:verify", {
            address: contractAddress,
            constructorArguments: args,
            contract: "contracts/OurToken.sol:OurToken",
        })
    } catch (e) {
        if (e.message.toLowerCase().includes("already verified")) {
            console.log("Already Verified!")
        } else {
            console.log(e)
        }
    }
}
module.exports = { verify }
