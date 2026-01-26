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
        """
                Table
        freq_count : list[str]
        [0..26]    : ["", ""]
        """

        freq_table = defaultdict(list[str])
        for s in strs:
            freq_count = [0] * 26
            for c in s:
                freq_count[ord(c) - ord("a")] += 1
            freq_table[tuple(freq_count)].append(s) # list's can't be hashed in python
        return list(freq_table.values())


solution = Solution()
strs = ["act", "pots", "tops", "cat", "stop", "hat"]
assert len(solution.groupAnagrams(strs)) == len(
    [["hat"], ["act", "cat"], ["stop", "pots", "tops"]]
)

strs = []
assert len(solution.groupAnagrams(strs)) == 0

strs = ["a", "b", "c"]
assert len(solution.groupAnagrams(strs)) == 3

strs = ["a", "a", "a"]
assert len(solution.groupAnagrams(strs)) == 1

print("It works")
