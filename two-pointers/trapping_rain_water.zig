/// You are given an array of non-negative integers heights which represent an elevation map.
/// Each value heights[i] represents the heights of a bar, which has a width of 1.
///
/// Return the maximum area of water that can be trapped between the bars.
///
/// Example 1:
/// Input: heights = [0,2,0,3,1,0,1,3,2,1]
/// Output: 9
///
/// Constraints:
///     1 <= heights.length <= 1000
///     0 <= heights[i] <= 1000
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn trap(heights: []const i32) i32 {
        assert(heights.len >= 2);
        assert(heights.len <= 1000);
        for (heights) |height| {
            assert(height >= 0);
            assert(height <= 1000);
        }

        var result: i32 = 0;
        var lo: usize = 0;
        var hi: usize = heights.len - 1;
        var left_max = heights[lo];
        var right_max = heights[hi];
        while (lo < hi) {
            switch (std.math.order(left_max, right_max)) {
                .lt => {
                    lo += 1;
                    left_max = @max(left_max, heights[lo]);
                    result += left_max - heights[lo];
                },
                .gt, .eq => {
                    hi -= 1;
                    right_max = @max(right_max, heights[hi]);
                    result += right_max - heights[hi];
                },
            }
        }

        return result;
    }
};

test "solution" {
    const T = struct {
        fn check(heights: []const i32, want: i32) !void {
            const got = Solution.trap(heights);
            std.debug.print("{any}: {d}\n", .{ heights, got });
            try testing.expectEqual(want, got);
        }
    };

    try T.check(&.{ 0, 2, 0, 3, 1, 0, 1, 3, 2, 1 }, 9);
    try T.check(&.{ 2, 1, 5, 3, 1, 0, 4 }, 9);
}
