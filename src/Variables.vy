# @version ^0.2.0

num: public(uint256)
password: String[20] # private variable

MY_CONSTAN: constant(uint256) = 123

@external
def __init__():
    self.num = 1
    self.password = "password123"

# environment variables

@external
@pure
def getBuiltInConstants() -> (address, uint256):
    return (ZERO_ADDRESS, MAX_UINT256)

@external
@payable
def returnEnvironmentVars() -> (
    uint256, address, uint256, uint256, uint256, address
):
    return (
        self.balance, 
        msg.sender, 
        msg.value, 
        block.number, 
        block.timestamp, 
        tx.origin
    )

# A calls B, B calls C
#    msg.sender = B
#    tx.origin  = C

