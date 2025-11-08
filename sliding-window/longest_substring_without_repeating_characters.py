"""
Given a string s, find the length of the longest substring without duplicate characters.

A substring is a contiguous sequence of characters within a string.

Example 1:
Input: s = "zxyzxyz"
Output: 3

Explanation: The string "xyz" is the longest without duplicate characters.

Example 2:
Input: s = "xxxx"
Output: 1

Constraints:
    0 <= s.length <= 1000
    s may consist of printable ASCII characters.
"""


class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        window: set[str] = set()
        longest_substring = 0

        left = 0
        for right in range(len(s)):
            while s[right] in window:
                window.remove(s[left])
                left += 1
            window.add(s[right])
            longest_substring = max(longest_substring, right - left + 1)
        return longest_substring


solution = Solution()
s = "zxyzxyz"
assert solution.lengthOfLongestSubstring(s) == 3


s = "xxxx"
assert solution.lengthOfLongestSubstring(s) == 1
