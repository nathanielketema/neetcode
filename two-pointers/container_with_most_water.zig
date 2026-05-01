/// You are given an integer array heights where heights[i] represents the height of the ithith bar.
///
/// You may choose any two bars to form a container. Return the maximum amount of
/// water a container can store.
///
/// Example 1:
/// Input: height = [1,7,2,5,4,7,3,6]
/// Output: 36
///
/// Example 2:
/// Input: height = [2,2,2]
/// Output: 4
///
/// Constraints:
///     2 <= height.length <= 1000
///     0 <= height[i] <= 1000
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn max_area(heights: []const i32) i32 {
        assert(heights.len >= 2);
        assert(heights.len <= 1000);
        for (heights) |height| {
            assert(height >= 0);
            assert(height <= 1000);
        }

        var result: i32 = 0;
        var lo: usize = 0;
        var hi: usize = heights.len - 1;
        while (lo < hi) {
            const width: i32 = @intCast(hi - lo);
            const height: i32 = @min(heights[hi], heights[lo]);

            const area = width * height;
            result = @max(result, area);

            switch (std.math.order(heights[lo], heights[hi])) {
                .lt => lo += 1,
                .gt, .eq => hi -= 1,
            }
        }

        return result;
    }
};

test "solution" {
    const T = struct {
        fn check(heights: []const i32, want: i32) !void {
            const got = Solution.max_area(heights);
            std.debug.print("{any}: {d}\n", .{ heights, got });

            try testing.expectEqual(want, got);
        }
    };

    try T.check(&.{ 1, 7, 2, 5, 4, 7, 3, 6 }, 36);
    try T.check(&.{ 2, 2, 2 }, 4);
}
