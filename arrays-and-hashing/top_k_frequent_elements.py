"""
Given an integer array nums and an integer k, return the k most frequent elements within the array.

The test cases are generated such that the answer is always unique.

You may return the output in any order.


Example 1:
Input: nums = [1,2,2,3,3,3], k = 2
Output: [2,3]

Example 2:
Input: nums = [7,7], k = 1
Output: [7]
"""
from collections import defaultdict


class Solution:
    def topKFrequent(self, nums: list[int], k: int) -> list[int]:
        count: defaultdict[int, int] = defaultdict(int)
        freq: list[list[int]] = [[] for _ in range(len(nums) + 1)] # n

        for num in nums:   # n
            count[num] += 1
        for num, cnt in count.items(): # n
            freq[cnt].append(num)

        res: list[int] = []
        for i in range(len(freq) - 1, 0, -1):
            for num in freq[i]:
                if len(res) == k:
                    return res
                res.append(num)
        return res


# Solution: Time - O(n), Space - O(n)
# Tip: when analyzing nested for loops, think of how many unique operations happen
