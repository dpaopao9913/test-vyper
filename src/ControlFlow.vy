# @version ^0.2.0

nums: public(uint256[3])

@external
def __init__():
    for i in [1,2,3]:
        self.nums[i-1] = i


@external
@pure
def ifElse(i: uint256) -> uint256:
    if i < 10:
        return 0
    elif i < 20:
        return 1
    else:
        return 2

@external
@view
def forLoop() -> (uint256, uint256, uint256):
    x: uint256 = 0
    for i in [1,2,3]:
        x += i

    y: uint256 = 0
    for i in self.nums:
        y += i

    z: uint256 = 0
    for i in range(10):
        z += 1

    return (x, y, z)





