pragma circom 2.0.0;

// Include necessary bits operations
include "comparators.circom";
include "bitify.circom";

template ArrayIncludes(n) {
    signal input array[n];
    signal input element;
    signal output included;
    
    component isEqual[n];
    signal intermediate[n];
    
    // Check if element equals any array element
    for (var i = 0; i < n; i++) {
        isEqual[i] = IsEqual();
        isEqual[i].in[0] <== array[i];
        isEqual[i].in[1] <== element;
        intermediate[i] <== isEqual[i].out;
    }
    
    // OR all results
    component or = MultiOR(n);
    for (var i = 0; i < n; i++) {
        or.in[i] <== intermediate[i];
    }
    included <== or.out;
}

template BingoWinVerifier() {
    // Public inputs
    signal input calledNumbers[75];
    signal input numCalled;
    
    // Private inputs
    signal input board[25];
    signal input winningLine[5];
    
    // Outputs
    signal output isValid;
    
    // Verify winning line numbers are called
    component numberChecks[5];
    for (var i = 0; i < 5; i++) {
        numberChecks[i] = ArrayIncludes(75);
        numberChecks[i].array <== calledNumbers;
        numberChecks[i].element <== board[winningLine[i]];
        numberChecks[i].included === 1;
    }
    
    // Verify line pattern
    signal lineDiffs[4];
    for (var i = 0; i < 4; i++) {
        lineDiffs[i] <== winningLine[i+1] - winningLine[i];
    }
    
    // All differences should be equal for valid line
    component diffChecks[3];
    for (var i = 0; i < 3; i++) {
        diffChecks[i] = IsEqual();
        diffChecks[i].in[0] <== lineDiffs[i];
        diffChecks[i].in[1] <== lineDiffs[i+1];
    }
    
    signal validDiffs;
    validDiffs <== diffChecks[0].out * diffChecks[1].out * diffChecks[2].out;
    
    isValid <== validDiffs;
}

component main = BingoWinVerifier();