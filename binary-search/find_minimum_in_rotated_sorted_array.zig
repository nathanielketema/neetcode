/// You are given an array of length n which was originally sorted in ascending order.
/// It has now been rotated between 1 and n times. For example,
/// the array nums = [1,2,3,4,5,6] might become:
///
///     [3,4,5,6,1,2] if it was rotated 4 times.
///     [1,2,3,4,5,6] if it was rotated 6 times.
///
/// Notice that rotating the array 4 times moves the last four elements of the array
/// to the beginning. Rotating the array 6 times produces the original array.
///
/// Assuming all elements in the rotated sorted array nums are unique, return the minimum
/// element of this array.
///
/// A solution that runs in O(n) time is trivial, can you write an algorithm that runs in O(log n) time?
///
/// Example 1:
/// Input: nums = [3,4,5,6,1,2]
/// Output: 1
///
/// Example 2:
/// Input: nums = [4,5,0,1,2,3]
/// Output: 0
///
/// Example 3:
/// Input: nums = [4,5,6,7]
/// Output: 4
///
/// Constraints:
///     1 <= nums.length <= 1000
///     -1000 <= nums[i] <= 1000
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn find_min(nums: []const i32) i32 {
        assert(nums.len >= 1);
        assert(nums.len <= 1000);
        for (0..nums.len - 1) |i| assert(nums[i] != nums[i + 1]);

        var lhs: usize = 0;
        var rhs: usize = nums.len - 1;
        while (lhs < rhs) {
            const mid = lhs + @divTrunc((rhs - lhs), 2);
            switch (std.math.order(nums[mid], nums[rhs])) {
                .lt => rhs = mid,
                .eq, .gt => lhs = mid + 1,
            }
        }

        return nums[lhs];
    }
};

test "solution" {
    const T = struct {
        fn check(nums: []const i32, want: i32) !void {
            const got = Solution.find_min(nums);
            std.debug.print("{any}: {d}\n", .{ nums, got });
            try testing.expectEqual(want, got);
        }
    };

    try T.check(&.{ 3, 4, 5, 6, 1, 2 }, 1);
    try T.check(&.{ 4, 5, 6, 1, 2, 3 }, 1);
    try T.check(&.{ 5, 1, 2, 3, 4 }, 1);
    try T.check(&.{-2}, -2);
    try T.check(&.{ 99, 1000, -999, -69 }, -999);
    try T.check(&.{ 4, 5, 0, 1, 2, 3 }, 0);
}
