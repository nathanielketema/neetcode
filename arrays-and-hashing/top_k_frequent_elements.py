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
        num_count = defaultdict(int)

        # O(n)
        for num in nums:
            num_count[num] += 1

        # O(n)
        bucket = [[] for _ in range(len(nums) + 1)]
        for num, count in num_count.items():
            bucket[count].append(num)

        result = []
        for i in range(k, len(bucket)):
            for j in range(len(bucket[i])):
                result.append(bucket[i][j])

        return result


solution = Solution()
nums, k = [1, 2, 2, 3, 3, 3, 4, 4], 2
assert solution.topKFrequent(nums, k) == [2, 4, 3]

nums, k = [7, 7], 1
assert solution.topKFrequent(nums, k) == [7]

nums, k = [1, 2, 3, 4], 1
assert solution.topKFrequent(nums, k) == [1, 2, 3, 4]

nums, k = [1, 1, 2, 3, 4], 2
assert solution.topKFrequent(nums, k) == [1]

nums, k = [1, 1, 2, 3, 4], 5
assert solution.topKFrequent(nums, k) == []
