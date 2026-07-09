/// You are given an integer array piles where piles[i] is the number of bananas in the ith pile.
/// You are also given an integer h, which represents the number of hours you have to eat all the
/// bananas.
///
/// You may decide your bananas-per-hours eating rate of k. Each hours, you may choose a pile of
/// bananas and eats k bananas from that pile. If the pile has less than k bananas,
/// you may finish eating the pile but you can not eat from another pile in the same hours.
///
/// Return the minimum integer k such that you can eat all the bananas within h hours.
///
/// Example 1:
/// Input: piles = [1,4,3,2], h = 9
/// Output: 2
///
///
/// Explanation: With an eating rate of 2, you can eat the bananas in 6 hours.
/// With an eating rate of 1, you would need 10 hours to eat all the bananas (which exceeds h=9),
/// thus the minimum eating rate is 2.
///
/// Example 2:
/// Input: piles = [25,10,23,4], h = 4
/// Output: 25
///
/// Constraints:
///     1 <= piles.length <= 1,000
///     piles.length <= h <= 1,000,000
///     1 <= piles[i] <= 1,000,000,000
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn min_eating_speed(piles: []const i32, hours: usize) usize {
        assert(piles.len >= 1);
        assert(piles.len <= 1_000);
        assert(hours >= piles.len);
        assert(hours <= 1_000_000);

        // O(n)
        const k_max: usize = mx: {
            var max: usize = 0;
            for (piles) |pile| max = @max(max, pile);
            break :mx max;
        };

        // O(nlog(k))
        var k: usize = k_max;
        var lhs: usize = 1;
        var rhs: usize = k_max;
        while (lhs <= rhs) {
            const mid: usize = lhs + @divTrunc((rhs - lhs), 2);
            const hrs: usize = time: {
                var h: usize = 0;
                for (piles) |pile| {
                    const p: usize = @intCast(pile);
                    h += (p + mid - 1) / mid;
                }
                break :time h;
            };

            switch (std.math.order(hrs, hours)) {
                .lt => {
                    k = mid;
                    rhs = mid - 1;
                },
                .gt, .eq => lhs = mid + 1,
            }
        }

        return k;
    }
};

test "solution" {
    const T = struct {
        fn check(piles: []const i32, hours: usize, want: usize) !void {
            const got = Solution.min_eating_speed(piles, hours);
            try testing.expectEqual(want, got);
            std.debug.print("{any}, {d}: {d}\n", .{ piles, hours, got });
        }
    };

    try T.check(&.{ 1, 4, 3, 2 }, 9, 2);
    try T.check(&.{ 25, 10, 23, 4 }, 4, 25);
}
