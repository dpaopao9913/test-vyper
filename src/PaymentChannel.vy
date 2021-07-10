# @version ^0.2.0

# ref video: https://www.youtube.com/watch?v=BVBlubp9q8s

sender: public(address)   # alice
receiver: public(address) # bob
DURATION: constant(uint256) = 7 * 24 * 60 * 60  # sec
expiresAt: public(uint256)

# constructor

@external
@payable
def __init__(_receiver: address):
    assert _receiver != ZERO_ADDRESS, "receiver == 0 address"
    self.sender = msg.sender
    self.receiver = _receiver
    self.expiresAt = block.timestamp + DURATION

# getHash function

@internal
@pure
def _getHash(_amount: uint256) -> bytes32:
    return keccak256(
        concat(
            convert(self, bytes32), 
            convert(_amount, bytes32)
        )
    )

@external
@view
def getHash(_amount: uint256) -> bytes32:
    return self._getHash(_amount)

# getEthSignedHash function

@internal
@view
def _getEthSignedHash(_amount: uint256) -> bytes32:
    hash: bytes32 = self._getHash(_amount)
    return keccak256(
        concat(
            b'\x19Ethereum Signed Message:\n32',
            hash
        )
    )

@external
@view
def getEthSignedHash(_amount: uint256) -> bytes32:
    return self._getEthSignedHash(_amount)

# verify function

@internal
@view
def _verify(_amount: uint256, _sig: Bytes[65]) -> bool:
    ethSignedHash: bytes32 = self._getEthSignedHash(_amount)
    r: uint256 = convert(slice(_sig, 0, 32), uint256)
    s: uint256 = convert(slice(_sig, 32, 32), uint256)
    v: uint256 = convert(slice(_sig, 64, 1), uint256)
    return ecrecover(ethSignedHash, v, r, s) == self.sender

@external
@view
def verify(_amount: uint256, _sig: Bytes[65]) -> bool:
    return self._verify(_amount, _sig)

# payment function 

@external
@nonreentrant("lock")
def close(_amount: uint256, _sig: Bytes[65]):
    assert msg.sender == self.receiver, "!receiver"
    assert self._verify(_amount, _sig), "invali sig"
    raw_call(self.receiver, b'\x00', value=_amount)
    selfdestruct(self.sender)

@external
def cancel():
    assert msg.sender == self.sender, "!sender"
    assert block.timestamp >= self.expiresAt, "!expired"
    selfdestruct(self.sender)
