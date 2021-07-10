# @version ^0.2.0

x: public(String[10])
owner: public(address)

@external
def __init__():
    self.owner = msg.sender

@internal
def _setX(sender: address, _x: String[10]):
    # assert self.owner == sender, "!owner"
    if self.owner != sender:
        raise "!owner"
    self.x = _x

@external
def setX(_x: String[10]):
    self._setX(msg.sender, _x)

# unreachable
@external
def unreachable():
    raise UNREACHABLE