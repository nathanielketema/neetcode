"""
You are given an integer array piles where piles[i] is the number of bananas in the ith pile. 
You are also given an integer h, which represents the number of hours you have to eat all the 
bananas.

You may decide your bananas-per-hours eating rate of k. Each hours, you may choose a pile of 
bananas and eats k bananas from that pile. If the pile has less than k bananas, 
you may finish eating the pile but you can not eat from another pile in the same hours.

Return the minimum integer k such that you can eat all the bananas within h hours.

Example 1:
Input: piles = [1,4,3,2], h = 9
Output: 2 


Explanation: With an eating rate of 2, you can eat the bananas in 6 hours. 
With an eating rate of 1, you would need 10 hours to eat all the bananas (which exceeds h=9), 
thus the minimum eating rate is 2.

Example 2:
Input: piles = [25,10,23,4], h = 4
Output: 25

Constraints:
    1 <= piles.length <= 1,000
    piles.length <= h <= 1,000,000
    1 <= piles[i] <= 1,000,000,000
"""

import math

# Brute Force
"""
class Solution:
    def minEatingSpeed(self, piles: list[int], h: int) -> int:
        k = 1
        hours = 0
        while hours <= h:
            for pile in piles:
                hours += math.ceil(pile / k)
            if hours <= h:
                return k
            k += 1
            hours = 0
        return k
"""      


class Solution:
    def minEatingSpeed(self, piles: list[int], h: int) -> int:
        left, right = 1, max(piles)
        result = right
        while left <= right:
            k = (left + right) // 2
            hours = 0
            for pile in piles:
                hours += math.ceil(pile / k)
            if hours <= h:
                result =  min(result, k)
                right = k - 1
            else:
                left = k + 1
        return result
