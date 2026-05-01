"""
You are given an array of non-negative integers height which represent an elevation map.
Each value height[i] represents the height of a bar, which has a width of 1.

Return the maximum area of water that can be trapped between the bars.

Example 1:
Input: height = [0,2,0,3,1,0,1,3,2,1]
Output: 9

Constraints:
    1 <= height.length <= 1000
    0 <= height[i] <= 1000
"""


class Solution:
    def trap(self, height: list[int]) -> int:
        max_trap = 0
        left, right = 0, len(height) - 1
        max_left, max_right = height[left], height[right]

        while left < right:
            if max_left < max_right:
                left += 1
                max_left = max(max_left, height[left])
                max_trap += max_left - height[left]
            else:
                right -= 1
                max_right = max(max_right, height[right])
                max_trap += max_right - height[right]

        return max_trap

    def brute_force(self, height: list[int]) -> int:
        result = 0
        for i in range(len(height) - 1):
            left_max = height[i]
            for j in range(i):
                left_max = max(left_max, height[j])

            right_max = height[i]
            for j in range(i + 1, len(height)):
                right_max = max(right_max, height[j])

            result += min(left_max, right_max) - height[i]

        return result
