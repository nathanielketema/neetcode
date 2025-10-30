const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn min_eating_speed(piles: []u64, max_hour: usize) usize {
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

test "test 1" {
    var piles = [_]u64{ 1, 4, 3, 2 };
    const max_hour: usize = 9;
    const solution = Solution.min_eating_speed(&piles, max_hour);
    try testing.expectEqual(2, solution);
}

test "test 2" {
    var piles = [_]u64{ 25, 10, 23, 4 };
    const max_hour: usize = 4;
    const solution = Solution.min_eating_speed(&piles, max_hour);
    try testing.expectEqual(25, solution);
}

test "test 3" {
    var piles = [_]u64{ 1, 1, 1, 9999999999 };
    const max_hour: usize = 4;
    const solution = Solution.min_eating_speed(&piles, max_hour);
    try testing.expectEqual(9999999999, solution);
}
