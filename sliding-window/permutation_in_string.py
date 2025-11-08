"""
You are given two strings s1 and s2.

Return true if s2 contains a permutation of s1, or false otherwise. That means if a
permutation of s1 exists as a substring of s2, then return true.

Both strings only contain lowercase letters.

Example 1:
Input: s1 = "abc", s2 = "lecabee"
Output: true

Explanation: The substring "cab" is a permutation of "abc" and is present in "lecabee".

Example 2:
Input: s1 = "abc", s2 = "lecaabee"
Output: false

Constraints:
    1 <= s1.length, s2.length <= 1000
"""

from collections import defaultdict


class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        if len(s1) > len(s2):
            return False

        s1_count: defaultdict[str, int] = defaultdict(int)
        s2_count: defaultdict[str, int] = defaultdict(int)

        for s in s1:  # O(n)
            s1_count[s] += 1

        left = 0
        for right in range(len(s1) - 1, len(s2)):  # O(n)
            for j in range(left, right + 1):  # O(n x m)
                s2_count[s2[j]] += 1
            if s1_count == s2_count:
                return True
            s2_count.clear()
            left += 1
        return False

        # Time: O(n*m)
        # Space: O(1) Because we're storing at most 26 letters


solution = Solution()
s1, s2 = "abc", "lecabee"
assert solution.checkInclusion(s1, s2)

s1, s2 = "abc", "lecaabee"
assert not solution.checkInclusion(s1, s2)
