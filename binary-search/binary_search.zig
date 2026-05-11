/// You are given an array of distinct integers nums, sorted in ascending order,
/// and an integer target.
///
/// Implement a function to search for target within nums. If it exists, then return its index,
/// otherwise, return -1.
///
/// Your solution must run in O(logn)) time.
///
/// Example 1:
/// Input: nums = [-1,0,2,4,6,8], target = 4
/// Output: 3
///
/// Example 2:
/// Input: nums = [-1,0,2,4,6,8], target = 3
/// Output: -1
///
/// Constraints:
///     1 <= nums.length <= 10000.
///     -10000 < nums[i], target < 10000
///     All the integers in nums are unique.
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn search(nums: []const i32, target: i32) i32 {
        assert(nums.len >= 1);
        assert(nums.len <= 1e4);

        var lhs: usize = 0;
        var rhs: usize = nums.len - 1;
        while (lhs <= rhs) {
            const mid: usize = lhs + @divTrunc((rhs - lhs), 2);
            switch (std.math.order(nums[mid], target)) {
                .lt => lhs = mid + 1,
                .gt => rhs = mid - 1,
                .eq => return @as(i32, @intCast(mid)),
            }
        }

        return -1;
    }
};

test "solution" {
    const T = struct {
        fn check(nums: []const i32, target: i32, want: i32) !void {
            const got = Solution.search(nums, target);
            std.debug.print("{any}, {d} -> {d}\n", .{nums, target, got});
            try testing.expectEqual(want, got);
        }
    };

    try T.check(&.{ -1, 0, 2, 4, 6, 8 }, 4, 3);
    try T.check(&.{ -1, 0, 2, 4, 6, 8 }, 3, -1);
}
