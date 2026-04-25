/// Given an integer array nums, return true if any value appears more than once in the array,
/// otherwise return false.
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn has_duplicate(gpa: Allocator, nums: []const i8) bool {
        var seen: std.AutoHashMap(i8, void) = .init(gpa);
        defer seen.deinit();

        for (nums) |num| {
            if (seen.contains(num)) return true;
            seen.put(num, {}) catch unreachable;
        }

        return false;
    }
};

test "solution" {
    const T = struct {
        fn check(nums: []const i8, expected: bool) !void {
            const gpa = testing.allocator;
            try testing.expectEqual(expected, Solution.has_duplicate(gpa, nums));
            std.debug.print("{any}: {any}\n", .{ nums, expected });
        }
    };

    try T.check(&.{ 2, 1, 2 }, true);
    try T.check(&.{ 2, 1, 0, -2 }, false);
    try T.check(&.{-2}, false);
    try T.check(&.{ -2, -2, -2 }, true);
    try T.check(&.{ 2, -2, -3, 4, 5, 2 }, true);
}
