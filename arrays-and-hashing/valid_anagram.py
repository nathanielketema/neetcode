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

        s_count: dict[str, int] = {}
        t_count: dict[str, int] = {}
        for i in range(len(s)):
            s_count[s[i]] = s_count.get(s[i], 0) + 1
            t_count[t[i]] = t_count.get(t[i], 0) + 1

        return s_count == t_count
