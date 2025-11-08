"""
You are given an integer array prices where prices[i] is the price of NeetCoin on the ith day.

You may choose a single day to buy one NeetCoin and choose a different day in the future 
to sell it.

Return the maximum profit you can achieve. You may choose to not make any transactions, 
in which case the profit would be 0.

Example 1:
Input: prices = [10,1,5,6,7,1]
Output: 6

Explanation: Buy prices[1] and sell prices[4], profit = 7 - 1 = 6.

Example 2:
Input: prices = [10,8,7,5,2]
Output: 0

Explanation: No profitable transactions can be made, thus the max profit is 0.

Constraints:

    1 <= prices.length <= 100
    0 <= prices[i] <= 100
"""

# Brute force O(n^2)
"""
class Solution:
    def maxProfit(self, prices: list[int]) -> int:
        max_profit = 0
        for i in range(len(prices)):
            profit = 0
            for j in range(i + 1, len(prices)):
                if prices[j] > prices[i]:
                    profit = max(profit, prices[j] - prices[i])
            max_profit = max(max_profit, profit)
        return max_profit
"""

# Two pointers O(n)
class Solution:
    def maxProfit(self, prices: list[int]) -> int:
        left, right = 0, 1
        max_profit = 0

        while right < len(prices):
            if prices[left] < prices[right]:
                max_profit = max(max_profit, prices[right] - prices[left])
            else:
                left = right
            right += 1
        return max_profit


solution = Solution()
prices = [10,1,5,6,7,1]
assert solution.maxProfit(prices) == 6

prices = [10,8,7,5,2]
assert solution.maxProfit(prices) == 0
