/// Valid Palindrome
///
/// Given a string s, return true if it is a palindrome, otherwise return false.
///
/// A palindrome is a string that reads the same forward and backward. It is also case-insensitive
/// and ignores all non-alphanumeric characters.
///
/// Note: Alphanumeric characters consist of letters (A-Z, a-z) and numbers (0-9).
///
/// Example 1:
/// Input: s = "Was it a car or a cat I saw?"
/// Output: true
/// Explanation: After considering only alphanumerical characters we have "wasitacaroracatisaw",
///              which is a palindrome.
///
/// Example 2:
/// Input: s = "tab a cat"
/// Output: false
/// Explanation: "tabacat" is not a palindrome.
///
/// Constraints:
///     1 <= s.length <= 1000
///     s is made up of only printable ASCII characters.
const std = @import("std");
const assert = std.debug.assert;
const ascii = std.ascii;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn is_palindrome(s: []const u8) bool {
        assert(s.len >= 1);
        assert(s.len <= 1000);
        for (s) |c| assert(ascii.isAscii(c));

        var lo: usize = 0;
        var hi: usize = s.len - 1;
        while (lo < hi) {
            while (lo < hi and !ascii.isAlphanumeric(s[lo])) lo += 1;
            while (lo < hi and !ascii.isAlphanumeric(s[hi])) hi -= 1;

            if (ascii.toLower(s[lo]) != ascii.toLower(s[hi])) {
                return false;
            }

            lo += 1;
            hi -= 1;
        }

        return true;
    }
};

test "solution" {
    const T = struct {
        fn check(s: []const u8, want: bool) !void {
            const got = Solution.is_palindrome(s);
            std.debug.print("{s}: {any}\n", .{ s, got });
            try testing.expectEqual(want, got);
        }
    };

    try T.check("Was it a car or a cat I saw?", true);
    try T.check("tab a cat", false);
    try T.check("123321", true);
}
