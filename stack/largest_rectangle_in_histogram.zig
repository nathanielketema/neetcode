/// You are given an array of integers heights where heights[i] represents the height of a bar.
/// The width of each bar is 1.
///
/// Return the area of the largest rectangle that can be formed among the bars.
///
/// Note: This chart is known as a histogram.
///
/// Example 1:
/// Input: heights = [7,1,7,2,2,4]
/// Output: 8
///
/// Example 2:
/// Input: heights = [1,3,7]
/// Output: 7
///
/// Constraints:
///     1 <= heights.length <= 1000.
///     0 <= heights[i] <= 1000
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn largest_rectangle_area(arena: Allocator, heights: []const u32) !u64 {
        assert(heights.len >= 1);
        assert(heights.len <= 1000);
        for (heights) |height| assert(height <= 1000);

        const Pair = struct {
            index: usize,
            height: u32,
        };

        var stack: std.ArrayList(Pair) = try .initCapacity(arena, heights.len);
        var max_area: u64 = 0;
        for (heights, 0..) |height, i| {
            var start_index = i;
            while (stack.getLastOrNull()) |pair| {
                if (pair.height <= height) break;

                _ = stack.pop();
                max_area = @max(max_area, pair.height * (i - pair.index));
                start_index = pair.index;
            }
            try stack.append(arena, .{ .index = start_index, .height = height });
        }

        for (stack.items) |pair| {
            max_area = @max(max_area, pair.height * (heights.len - pair.index));
        }

        return max_area;
    }
};

test "solution" {
    const T = struct {
        fn check(heights: []const u32, want: u32) !void {
            var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            defer arena_instance.deinit();
            const arena = arena_instance.allocator();

            const got = try Solution.largest_rectangle_area(arena, heights);
            std.debug.print("{any}: {d}\n", .{ heights, got });
            try testing.expectEqual(want, got);
        }
    };

    try T.check(&.{ 7, 1, 7, 2, 2, 4 }, 8);
    try T.check(&.{ 1, 3, 7 }, 7);
}
