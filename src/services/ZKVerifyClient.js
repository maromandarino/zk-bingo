export class ZKVerifyClient {
  constructor(nodeUrl, options = {}) {
    this.nodeUrl = nodeUrl;
    this.options = {
      timeout: options.timeout || 30000,
      retryInterval: options.retryInterval || 5000
    };
  }

  async submitProof(proof, publicSignals) {
    try {
      const response = await fetch(`${this.nodeUrl}/rpc`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          jsonrpc: '2.0',
          method: 'zkverify_submitProof',
          params: [{
            proof,
            publicSignals,
            circuit: 'bingo_win',
            version: '1.0'
          }],
          id: Date.now()
        })
      });

      if (!response.ok) {
        throw new Error(`ZKVerify submission error: ${response.statusText}`);
      }

      const result = await response.json();
      return {
        proofId: result.result.proofId,
        status: result.result.status
      };
    } catch (error) {
      console.error('Error submitting proof to ZKVerify:', error);
      throw error;
    }
  }
}