# @version ^0.2.0

"""
Ref types:
- list
- mappings
- structs
"""
struct Person:
    name: String[100]
    age: uint256

nums: public(uint256[10])
myMap: public(HashMap[address, uint256])
person: public(Person)

@external
def __init__():
    self.nums[5] = 123
    self.myMap[msg.sender] = 456
    self.person.name = "Vyper"

    arr: uint256[10] = self.nums
    arr[0] = 999 # not worked
