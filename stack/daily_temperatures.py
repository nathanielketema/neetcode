"""
You are given an array of integers temperatures where temperatures[i] represents 
the daily temperatures on the ith day.

Return an array result where result[i] is the number of days after the ith day 
before a warmer temperature appears on a future day. If there is no day in the 
future where a warmer temperature will appear for the ith day, set result[i] to 0 instead.

Example 1:
Input: temperatures = [30,38,30,36,35,40,28]
Output: [1,4,1,2,1,0,0]

Example 2:
Input: temperatures = [22,21,20]
Output: [0,0,0]

Constraints:
    1 <= temperatures.length <= 1000.
    1 <= temperatures[i] <= 100
"""

# Brute Force
"""
class Solution:
    def dailyTemperatures(self, temperatures: list[int]) -> list[int]:
        result = []
        for i in range(len(temperatures)):
            j = i + 1
            while j < len(temperatures) and temperatures[j] < temperatures[i]: j += 1
            if j < len(temperatures):
                result[i] = j - i
            else:
                result[i] = 0
        return result
"""

class Solution:
    def dailyTemperatures(self, temperatures: list[int]) -> list[int]:
        result = [0] * len(temperatures)
        stack = []  # pair: [temp, index]

        for i, t in enumerate(temperatures):
            while stack and t > stack[-1][0]:
                _, stackInd = stack.pop()
                result[stackInd] = i - stackInd
            stack.append((t, i))
        return result
