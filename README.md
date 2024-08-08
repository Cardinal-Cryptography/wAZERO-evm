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

Contract ABI and bytecode can be found in the `artifacts` directory.

Addresses of deployed (and verified contracts) for Aleph Zero EVM networks:

- Testnet: `0x074f31A128ef4B582A5e6Dd0ef4c1D5142E71D77`
- Mainnet: `???`



