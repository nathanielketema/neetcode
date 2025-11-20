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
        if len(strs) == 0:
            return []

        count_map: defaultdict[tuple[int, ...], list[str]] = defaultdict(list)
        for s in strs:
            count: list[int] = [0] * 26
            for c in s:
                count[ord(c) - ord("a")] += 1
            count_map[tuple(count)].append(s)

        return list(count_map.values())


solution = Solution()
strs = ["act", "pots", "tops", "cat", "stop", "hat"]
assert len(solution.groupAnagrams(strs)) == len(
    [["hat"], ["act", "cat"], ["stop", "pots", "tops"]]
)
