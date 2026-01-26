"""
Longest Consecutive Sequence

Given an array of integers nums, return the length of the longest consecutive sequence of elements
that can be formed.

A consecutive sequence is a sequence of elements in which each element is exactly 1 greater than
the previous element. The elements do not have to be consecutive in the original array.

You must write an algorithm that runs in O(n) time.

Example 1:
Input: nums = [2,20,4,10,3,4,5]
Output: 4
Explanation: The longest consecutive sequence is [2, 3, 4, 5].

Example 2:
Input: nums = [0,3,2,5,4,6,1,1]  -> [0,1,1,2,3,4,5,6]
Output: 7

Constraints:
    0 <= nums.length <= 1000
    -10^9 <= nums[i] <= 10^9
"""


class Solution:
    """
    [] -> 0
    [1..n] -> max = n, min = 1

    sequence:
    - [start, start + 1, start + 2, start + 3, start + n]
    - start - 1 does not exist in the list

    step 1: see all numbers
    step 2: check if num - 1 exists
        - if it does, move on
        - it it doesn't -> you've found your start
          - traverse the list by finding start + 1
    """

    def longestConsecutive(self, nums: list[int]) -> int:
        if len(nums) == 0:
            return 0

        longest = 0
        seen = set(nums)
        for num in nums:
            if num - 1 not in seen:
                count = 1
                while num + count in seen:
                    count += 1
                longest = max(longest, count)
        return longest


solution = Solution()
nums = [2, 20, 4, 10, 3, 4, 5]
assert solution.longestConsecutive(nums) == 4

nums = []
assert solution.longestConsecutive(nums) == 0

nums = [1, 7, 9, 17]
assert solution.longestConsecutive(nums) == 1

nums = [1, 2, 3, 4, 5, 6]
assert solution.longestConsecutive(nums) == 6

nums = [0, 3, 2, 5, 4, 6, 1, 1]
assert solution.longestConsecutive(nums) == 7

print("It works")
