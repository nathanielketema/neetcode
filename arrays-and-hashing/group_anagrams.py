"""
Given an array of strings strs, group all anagrams together into sublists.
You may return the output in any order.

An anagram is a string that contains the exact same characters as another string,
but the order of the characters can be different.


Example 1:
Input: strs = ["act","pots","tops","cat","stop","hat"]
Output: [["hat"],["act", "cat"],["stop", "pots", "tops"]]

Example 2:
Input: strs = ["x"]
Output: [["x"]]
"""

from collections import defaultdict


class Solution:
    def groupAnagrams(self, strs: list[str]) -> list[list[str]]:
        result: defaultdict[tuple[int, ...], list[str]] = defaultdict(list) # char_count:list_of_anagrams
        for string in strs:             # n (number of strs)
            count = [0] * 26
            for char in string:          # n * m(number of chars)
                count[ord(char) - ord('a')] += 1
            result[tuple(count)].append(string)
        return list(result.values())

# Solution: Time - O(m * n) and Space - O(n)
