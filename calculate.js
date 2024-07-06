const { ethers } = require("ethers");

function showContractAddress(tx) {
    return ethers.getCreateAddress(tx);
}

const ARGV = process.argv.slice(2);

console.log(
    showContractAddress({
            from: ARGV[0],
            nonce: parseInt(ARGV[1]),
    })
)
