"""
Minimum Window Substring

Given two strings s and t, return the shortest substring of s such that every character in t,
including duplicates, is present in the substring. If such a substring does not exist,
return an empty string "".

You may assume that the correct output is always unique.

Example 1:
Input: s = "OUZODYXAZV", t = "XYZ"
Output: "YXAZ"

Explanation: "YXAZ" is the shortest substring that includes "X", "Y", and "Z" from string t.

Example 2:
Input: s = "xyz", t = "xyz"
Output: "xyz"

Example 3:
Input: s = "x", t = "xy"
Output: ""

Constraints:
    1 <= s.length <= 1000
    1 <= t.length <= 1000
    s and t consist of uppercase and lowercase English letters.
"""

from collections import defaultdict


class Solution:
    def minWindow(self, s: str, t: str) -> str:
        if len(s) < len(t) or t == "":
            return ""

        count_t: defaultdict[str, int] = defaultdict(int)
        window: defaultdict[str, int] = defaultdict(int)

        for char in t:
            count_t[char] += 1

        have, need = 0, len(count_t)
        result, result_length = [-1, -1], float("infinity")
        left = 0
        for right in range(len(s)):
            window[s[right]] += 1

            if s[right] in count_t and window[s[right]] == count_t[s[right]]:
                have += 1

            while have == need:
                if (right - left + 1) < result_length:
                    result = [left, right]
                    result_length = right - left + 1

                window[s[left]] -= 1
                if s[left] in count_t and window[s[left]] < count_t[s[left]]:
                    have -= 1
                left += 1
        left, right = result
        return s[left : right + 1] if result_length != float("infinity") else ""


solution = Solution()
s, t = "OUZODYXAZV", "XYZ"
assert solution.minWindow(s, t) == "YXAZ"

s, t = "xyz", "xyz"
assert solution.minWindow(s, t) == "xyz"

s, t = "x", "xy"
assert solution.minWindow(s, t) == ""

s, t = "YUZODYXAZV", "YDYXAZ"
assert solution.minWindow(s, t) == "YUZODYXA"
