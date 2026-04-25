"""
Design an algorithm to encode a list of strings to a single string.
The encoded string is then decoded back to the original list of strings.

Please implement encode and decode

Example 1:
Input: ["neet","code","love","you"]
Output:["neet","code","love","you"]

Example 2:
Input: ["we","say",":","yes"]
Output: ["we","say",":","yes"]
"""


class Solution:
    def encode(self, strs: list[str]) -> str:
        result = ""
        for s in strs:
            result += str(len(s)) + "#" + s
        return result

    def decode(self, s: str) -> list[str]:
        result = []
        i = 0
        while i < len(s):
            j = i
            while s[j] != "#":
                j += 1
            size = int(s[i:j])
            j += 1
            result.append(s[j : j + size])
            i = j + size
        return result


solution = Solution()
strings = ["neet", "code", "loves", "you", "", "thisIsAVeryLongStringToCheckForInVariant"]
encoded = solution.encode(strings)
decoded = solution.decode(encoded)
assert decoded == strings
