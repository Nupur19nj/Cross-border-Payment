import {ethers} from "ethers";
const {abi} = require("./contracts/basicABI.json");

const provider = new ethers.BrowserProvider(window.ethereum)
await provider.send("eth_requestAccounts",[]);
const signer  = await provider.getSigner();
const contract = new ethers.Contract("0xc1c23A850CF85bD3E9169c55A27C5e4614cFa767",abi,signer);
async function main() {
  
  console.log("balance is "+await contract.balanceOf());
 
}

async function balance(){
  const balance = await contract.balanceOf();
  return balance;
}

async function deposit(amount){
  const deposit = await contract.depositToken(amount);
  contract.on("Deposit",(user,amount,balance)=>{
    return {user,amount,balance};
  })
}
async function withdrawal(amount){
  const withdrawal = await contract.withdrawToken(amount);
  contract.on("Withdraw",(user,amount,balance)=>{
    return {user,amount,balance};
  })
}
async function transfer(to,amount){
  const transfer = await contract.transfer(to,amount);
  contract.on("Transfer",(from,to,balance)=>{
    return {from,to,balance};
  })
}
async function getAllTransactions(){
  const getAllTransactions = await contract.getAllTransactions();
  return getAllTransactions;
}

async function findBalance(addr){
  const findBalance = await contract.findBalance(addr);
  return findBalance;
}

export {main,balance,deposit,withdrawal,transfer,getAllTransactions,findBalance};
