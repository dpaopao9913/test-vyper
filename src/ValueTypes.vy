# @version ^0.2.0

b: public(bool)
i: public(int128)
u: public(uint256)
d: public(decimal)
addr: public(address)
b32: public(bytes32)
bs: public(Bytes[100])
s: public(String[100])

@external
def __init__():
    self.b = True
    self.i = -1
    self.u = 123
    self.d = 3.14  # fail
    self.addr = 0x6443F58e7acA3Ffb1DA938c2a001DE6eB5a30651
    self.b32 = 0x6e91ec6b618bb462a4a6ee5aa2cb0e9cf30f7a052bb467b0ba58b8748c00d2e5
    self.bs = b"\x01"
    self.s = "This is a string."