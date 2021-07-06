# @version ^0.2.0

num: public(uint256)
message: public(String[10])
value: public(uint256)
owner: public(address)

@external
@payable
def __init__():
    self.owner = msg.sender
    self.value = msg.value


# visibility exmaples

@external
@pure
def simple(x: uint256, b: bool, s: String[10]) -> (uint256, bool, String[100]):
    return (x + 1, not b, concat(s, "?"))

@internal
@pure
def intFunc(x: uint256, y: uint256) -> (uint256, bool):
    return (x + y, True)

@external
@view
def extFunc(x: uint256) -> uint256:
    i: uint256 = 1
    b: bool = False

    (i, b) = self.intFunc(1, 2)
    return x * x


# mutability exmaples

@external
@pure
def pureFunc(x: uint256) -> bool:
    return x > 2

@external
@view
def viewFunc(x: uint256) -> (uint256, address):
    return (x + self.num, msg.sender)

@external
def writeSomething(_message: String[10]):
    self.message = _message

@external
@payable
def receiveEther():
    self.value = msg.value
