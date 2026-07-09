/// You are given two integer arrays nums1 and nums2 of size m and n respectively,
/// where each is sorted in ascending order. Return the median value among all elements
/// of the two arrays.
///
/// Your solution must run in O(log(m+n)) time.
///
/// Example 1:
/// Input: nums1 = [1,2], nums2 = [3]
/// Output: 2.0
///
/// Explanation: Among [1, 2, 3] the median is 2.
///
/// Example 2:
/// Input: nums1 = [1,3], nums2 = [2,4]
/// Output: 2.5
///
/// Explanation: Among [1, 2, 3, 4] the median is (2 + 3) / 2 = 2.5.
///
/// Constraints:
///     nums1.length == m
///     nums2.length == n
///     0 <= m <= 1000
///     0 <= n <= 1000
///     -10^6 <= nums1[i], nums2[i] <= 10^6
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn find_median_sorted_arrays(gpa: Allocator, nums1: []const i32, nums2: []const i32) !f32 {
        const nums: []i32 = nm: {
            var merged: std.ArrayList(i32) = .empty;
            errdefer merged.deinit(gpa);

            var i: usize = 0;
            var j: usize = 0;
            while (i < nums1.len and j < nums2.len) {
                switch (std.math.order(nums1[i], nums2[j])) {
                    .eq, .lt => {
                        try merged.append(gpa, nums1[i]);
                        i += 1;
                    },
                    .gt => {
                        try merged.append(gpa, nums1[j]);
                        j += 1;
                    },
                }
            }
            try merged.appendSlice(gpa, nums1[i..]);
            try merged.appendSlice(gpa, nums2[j..]);

            break :nm try merged.toOwnedSlice(gpa);
        };
        defer gpa.free(nums);

        if (nums.len % 2 == 0) {
            const mid = nums.len / 2;
            const sum: f32 = @floatFromInt(nums[mid - 1] + nums[mid]);
            return sum / 2;
        }  

        return @floatFromInt(nums[(nums.len - 1) / 2]);
    }
};

test "solution" {
    const T = struct {
        fn check(nums1: []const i32, nums2: []const i32, want: f32) !void {
            const got = try Solution.find_median_sorted_arrays(testing.allocator, nums1, nums2);
            try testing.expectEqual(want, got);
            std.debug.print("{any}, {any}: {d}\n", .{ nums1, nums2, got });
        }
    };

    try T.check(&.{ 1, 3 }, &.{ 2, 4 }, 2);
    try T.check(&.{ 1, 2 }, &.{3}, 2);
}
