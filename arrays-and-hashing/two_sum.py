"""
Given an array of integers nums and an integer target, return the indices i and j such 
that nums[i] + nums[j] == target and i != j.

You may assume that every input has exactly one pair of indices i and j that satisfy the condition.

Return the answer with the smaller index first. 

Input: 
nums = [3,4,5,6], target = 7
Output: [0,1]
"""

# num[i] + num[j] = target
# diff = target - num[i]
class Solution:
    def twoSum(self, nums: list[int], target: int) -> list[int]:
        seen: dict[int, int] = {} # num: index
        for i, num in enumerate(nums):
            diff = target - num
            if diff in seen:
                return [seen[diff], i]
            seen[num] = i
        return []
