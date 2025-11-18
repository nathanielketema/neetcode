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
        result: list[str] = []
        i = 0
        while i < len(s):
            j = i
            while s[j] != '#':
                j += 1

            # The reason this is not s[i] is because the length could be more than one digit
            length = int(s[i:j])
            result.append(s[j + 1 : j + 1 + length])
            i = j + 1 + length
        return result


solution = Solution()
strs = ["neet", "code", "loves", "you", "", "thisIsAVeryLongStringToCheckForInVariant"]
s = solution.encode(strs)
assert solution.decode(s) == strs
