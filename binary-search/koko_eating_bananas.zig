const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn min_eating_speed(piles: []u8, max_hour: usize) usize {
        var left: usize = 1;
        var right: usize = 0;
        for (piles) |pile| {
            right = @max(right, pile);
        }

        var result: usize = right;
        while (left <= right) {
            const k = (left + right) / 2;
            var hour: usize = 0;
            for (piles) |pile| {
                hour += (pile + k - 1) / k;
            }

            if (hour < max_hour) {
                result = @min(result, k);
                right = k - 1;
            } else {
                left = k + 1;
            }
        }

        return result;
    }
};

test "test solution" {
    // test 1
    var piles_1 = [_]u8{ 1, 4, 3, 2 };
    var max_hour: usize = 9;
    var solution = Solution.min_eating_speed(&piles_1, max_hour);
    try testing.expectEqual(2, solution);

    // test 2
    var piles_2 = [_]u8{ 25, 10, 23, 4 };
    max_hour = 4;
    solution = Solution.min_eating_speed(&piles_2, max_hour);
    try testing.expectEqual(25, solution);

    // test 3
    var piles_3 = [_]u8{ 1, 1, 1, 99 };
    max_hour = 4;
    solution = Solution.min_eating_speed(&piles_3, max_hour);
    try testing.expectEqual(99, solution);
}
