"""
You are given an array of integers nums and an integer k. There is a sliding window
of size k that starts at the left edge of the array. The window slides one position
to the right until it reaches the right edge of the array.

Return a list that contains the maximum element in the window at each step.

Example 1:
Input: nums = [1,2,1,0,4,2,6], k = 3
Output: [2,2,4,4,6]

Explanation:
Window position            Max
---------------           -----
[1  2  1] 0  4  2  6        2
 1 [2  1  0] 4  2  6        2
 1  2 [1  0  4] 2  6        4
 1  2  1 [0  4  2] 6        4
 1  2  1  0 [4  2  6]       6

Constraints:
    1 <= nums.length <= 1000
    -10,000 <= nums[i] <= 10,000
    1 <= k <= nums.length
"""

# Brute Force
"""
class Solution:
    def maxSlidingWindow(self, nums: list[int], k: int) -> list[int]:
        result: list[int] = []
        left = 0
        for right in range(k - 1, len(nums)):
            max_val = float("-inf")
            for j in nums[left:right+1]:
                max_val = max(max_val, j)
            result.append(int(max_val))
            left += 1
        return result

    # Time: O(n * k)
    # Space: O(n - k + 1)
"""

from collections import deque


class Solution:
    def maxSlidingWindow(self, nums: list[int], k: int) -> list[int]:
        result: list[int] = []
        queue: deque[int] = deque()

        left = 0
        for right in range(len(nums)):
            while queue and nums[queue[-1]] < nums[right]:
                _ = queue.pop()
            queue.append(right)

            if left > queue[0]:
                _ = queue.popleft()
            if (right + 1) >= k:
                result.append(nums[queue[0]])
                left += 1
        return result
    # Time: O(n)
    # Space: O(n)

solution = Solution()
nums, k = [1, 2, 1, 0, 4, 2, 6], 3
assert solution.maxSlidingWindow(nums, k) == [2, 2, 4, 4, 6]
