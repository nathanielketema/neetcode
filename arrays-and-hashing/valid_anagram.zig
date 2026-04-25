/// Given two strings s and t, return true if the two strings are anagrams of each other,
/// otherwise return false.
/// 
/// An anagram is a string that contains the exact same characters as another string,
/// but the order of the characters can be different.
/// 
/// Input: s = "racecar", t = "carrace"
/// Output: true
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn is_anagram(s: []const u8, t: []const u8) bool {
        if (s.len != t.len) return false;
        const count = s.len;

        var s_count: [26]u8 = .{0} ** 26;
        var t_count: [26]u8 = .{0} ** 26;
        for (0..count) |i| {
            s_count[s[i] - 'a'] += 1;
            t_count[t[i] - 'a'] += 1;
        }

        return std.mem.eql(u8, &s_count, &t_count);
    }
};

test "solution" {
    const T = struct {
        fn check(s: []const u8, t: []const u8, want: bool) !void {
            const got = Solution.is_anagram(s, t);
            try testing.expectEqual(want, got);

            std.debug.print("{s} & {s} -> {any}\n", .{ s, t, got });
        }
    };

    try T.check("racecar", "carrace", true);
    try T.check("cat", "tac", true);
    try T.check("foo", "bar", false);
}
