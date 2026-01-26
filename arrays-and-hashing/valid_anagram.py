"""
Given two strings s and t, return true if the two strings are anagrams of each other,
otherwise return false.

An anagram is a string that contains the exact same characters as another string,
but the order of the characters can be different.

Input: s = "racecar", t = "carrace"
Output: true
"""


class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False

        # char : count
        s_count = {}
        t_count = {}
        for i in range(len(s)):
            s_count[s[i]] = s_count.get(s[i], 0) + 1
            t_count[t[i]] = t_count.get(t[i], 0) + 1

        return s_count == t_count

    def isAnagram2(self, s: str, t: str) -> bool:
        """ Using defaultdict """
        from collections import defaultdict
        if len(s) != len(t):
            return False

        # char : count
        s_count = defaultdict(int)
        t_count = defaultdict(int)
        for i in range(len(s)):
            s_count[s[i]] += 1
            t_count[t[i]] += 1

        return s_count == t_count


solution = Solution()
s, t = "racecar", "carrace"
assert solution.isAnagram(s, t)


solution = Solution()
s, t = "racecar", "carrace"
assert solution.isAnagram2(s, t)
