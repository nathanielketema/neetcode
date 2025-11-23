"""
Given an integer array nums, return an array output where output[i] is the product of 
all the elements of nums except nums[i].

Each product is guaranteed to fit in a 32-bit integer.

Follow-up: Could you solve it in O(n) time without using the division operation?

Example 1:
Input: nums = [1,2,4,6]
Output: [48,24,12,8]

Example 2:
Input: nums = [-1,0,1,2,3]
Output: [0,-6,0,0,0]
"""


class Solution:
    def productExceptSelf(self, nums: list[int]) -> list[int]:
        product, zeros = 1, 0
        for num in nums:
            if num == 0:
                zeros += 1
            else:
                product *= num

        result: list[int] = [0] * len(nums)
        if zeros > 1:
            return result

        for i in range(len(nums)):
            if nums[i] == 0:
                result[i] = product
            elif zeros == 1:
                result[i] = 0
            else:
                result[i] = int(product / nums[i])
        return result

solution = Solution()
nums = [1,2,4,6]
assert solution.productExceptSelf(nums) == [48,24,12,8]



class Solution2:
    def productExceptSelf(self, nums: list[int]) -> list[int]:
        result: list[int] = [1] * len(nums)

        left_product = 1
        for i in range(len(nums)):
            result[i] = left_product
            left_product *= nums[i]

        right_product = 1
        for i in range(len(nums) - 1, -1, -1):
            result[i] *= right_product
            right_product *= nums[i]

        return result

solution = Solution()
nums = [1,2,4,6]
assert solution.productExceptSelf(nums) == [48,24,12,8]
