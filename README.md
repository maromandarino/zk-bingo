# ZK Bingo

A bingo game implementation with zero-knowledge proof verification using Circom and zkVerify.

## Overview

This project implements a bingo game where win verification is done using zero-knowledge proofs. Players can play bingo while keeping their board private, and wins are verified without revealing the actual numbers.

### Key Features
- Private board generation
- Zero-knowledge win verification
- Integration with zkVerify network
- Real-time proof status updates

## Technical Stack
- React for the frontend interface
- Circom for zero-knowledge circuit implementation
- zkVerify for proof verification

## Components

### Game Interface
- Interactive bingo board
- Number calling system
- Win detection with ZK proofs

### Proof Generation
- Circom circuit for win verification
- Proof generation service

### Verification
- zkVerify client integration
- Consensus-based verification

## Development

### Prerequisites
- Node.js >= 16
- npm >= 8
- circom 2.0.0
- snarkjs

### Setup
1. Clone the repository
```bash
git clone https://github.com/maromandarino/zk-bingo.git
cd zk-bingo
```

2. Install dependencies
```bash
npm install
```

3. Compile the circuit
```bash
npm run build:circuit
```

4. Start the development server
```bash
npm start
```

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
MIT