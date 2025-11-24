# 🎮 Rock–Paper–Scissors Blockchain Game (Sepolia Testnet)

A simple blockchain-based Rock–Paper–Scissors game built with **Solidity**, **ethers.js**, and **MetaMask**.  
The smart contract is deployed on the **Sepolia Testnet**, and the frontend interacts directly with the blockchain.

---

## 🚀 Features
- On-chain Rock–Paper–Scissors logic written in Solidity.
- Frontend uses `ethers.js` to interact with the contract via MetaMask.
- Easy local development server (no build step required).
- Designed for Sepolia testnet — use Sepolia ETH from a faucet for transactions.

---

## 1️⃣ Requirements
Before starting, make sure you have:
- [MetaMask](https://metamask.io/) browser extension installed and configured.
- Sepolia ETH (get it from a Sepolia faucet).
- Python 3.x installed (used to run a simple local HTTP server).
- A deployed smart contract address (see "Deploy the Smart Contract").
  
---

## 2️⃣ Deploy the Smart Contract
1. Open Remix IDE: `https://remix.ethereum.org`  
2. Create a new file called `Smart_contract.sol`.  
3. Copy & paste your full Solidity contract code into `Smart_contract.sol`.  
   - Compile the contract with **Solidity 0.8.19**.
4. Go to the **Deploy & Run** panel.
   - Set **Environment** to **Injected Provider (MetaMask)**.
   - Ensure MetaMask is connected to the **Sepolia Testnet** and you have Sepolia ETH.
5. Deploy the contract from Remix.
6. Copy the deployed contract address — you will need it for the frontend.

> **Tip:** Keep the contract ABI (from Remix's compilation) — the frontend may need it if it isn't already bundled.

---

## 3️⃣ Update the Frontend
Open `index.html` (or wherever the frontend stores the contract address) and update:

```js
const CONTRACT_ADDRESS = "YOUR_CONTRACT_ADDRESS_HERE";
```

Replace `"YOUR_CONTRACT_ADDRESS_HERE"` with the actual deployed contract address.

If your frontend needs the ABI, save the ABI JSON and ensure the frontend loads it (for example `contractABI.json`), or inline the ABI into your JavaScript.

---

## 4️⃣ Start Local Web Server
Browsers block blockchain scripts loaded from `file://`, so serve the frontend over `http://`.

In your project folder run:

Clone the Repository
```bash
git clone https://github.com/dhatrishv/Smart_Contract_Batch-B2.git
cd Smart_Contract_Batch-B2
python -m http.server 8000
\\ open the browser and check
http://localhost:8000
```
---

## 5️⃣ Connect Wallet & Play
1. Click **Connect Wallet** on the site.
2. Select your MetaMask Sepolia account.
3. Choose **Rock**, **Paper**, or **Scissors** in the UI.
4. Confirm the transaction in MetaMask (this sends a transaction to the Sepolia testnet).
5. The game result will appear on the UI (based on the contract logic).

---

## ⚙️ Configuration & Notes
- If your frontend uses environment variables (e.g. a `.env`), add `REACT_APP_CONTRACT_ADDRESS` (or equivalent) as needed.
- If building a production bundle, make sure to include the correct network and contract address for the intended deployment.
- Double-check the contract's gas usage and any `payable` requirements before sending transactions.

---

## 🧰 Troubleshooting
- **MetaMask not connecting**: Ensure the extension is unlocked and the site is allowed to connect. Check that MetaMask network is set to **Sepolia**.
- **Transaction failing**: Confirm you have Sepolia ETH and that the contract address/ABI are correct.
- **Frontend shows `file://` errors**: Make sure you've started the local server (`python -m http.server 8000`) and are visiting `http://localhost:8000`.
- **Wrong contract ABI**: Re-compile in Remix and copy the ABI JSON from the compilation tab.

---

## 📁 Example Project Structure
```
/project-root
├─ index.html
├─ Smart_contract.sol         
└─ README.md
```

---

## 👥 Contributing
Contributions are welcome! Suggested workflow:
1. Fork the repository.
2. Create a branch: `git checkout -b fix/feature-name`.
3. Make changes and test locally.
4. Open a pull request with a clear description.

---

