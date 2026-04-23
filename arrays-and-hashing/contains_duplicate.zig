/// Given an integer array nums, return true if any value appears more than once in the array,
/// otherwise return false.
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

const Io = std.Io;
const Allocator = std.mem.Allocator;

//   ```py
//   seen = sets()
//   for num in nums:
//      if num in seens:
//         return true
//      seen.add(num)
//   ```

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

fn check(nums: []const i8, expected: bool) !void {
    const gpa = testing.allocator;
    try testing.expectEqual(expected, Solution.has_duplicate(gpa, nums));
}

test "solution" {
    try check(&.{2, 1, 2}, true);
    try check(&.{2, 1, 0, -2}, false);
    try check(&.{-2}, false);
    try check(&.{-2, -2, -2}, true);
    try check(&.{2, -2, -3, 4, 5, 2}, true);
}
