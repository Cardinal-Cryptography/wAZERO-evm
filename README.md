## Wrapped AZERO Solidity implementation

A simple AZERO wrapped token based on WETH9 Solidity implementation.

### Testing

To test the contract, run the following commands:

```bash
forge test
```

### Deployment

To deploy the contract, run the following commands:

```bash
forge create --rpc-url <your_rpc_url> \
    --private-key <your_private_key> \
    --verify \
    src/wAZERO.sol:WAZERO
```

## Addresses and ABIs

Contract ABI can be found in the `abi` directory.

Addresses of deployed (and verified contracts) for Aleph Zero EVM networks:

- Testnet: `???`
- Mainnet: `???`



