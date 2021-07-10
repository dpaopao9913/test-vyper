# @version ^0.2.0

# signature verification
# ref video: https://www.youtube.com/watch?v=7EyrUo5iBCQ

"""
1. hash a message to sign
2. sign message hash offchain
3. verufy signature on chain
"""

@external
@pure
def getHash(_str: String[100]) -> bytes32:
    return keccak256(_str)

@external
@pure
def getEthSignedHash(_hash: bytes32) -> bytes32:
    return keccak256(concat(b'\x19Ethereum Signed Message:\n32', _hash))

@external
@pure
def verify(_ethSignedHash: bytes32, _sig: Bytes[65]) -> address:
    r: uint256 = convert(slice(_sig, 0, 32), uint256)
    s: uint256 = convert(slice(_sig, 32, 32), uint256)
    v: uint256 = convert(slice(_sig, 64, 1), uint256)
    return ecrecover(_ethSignedHash, v, r, s)
