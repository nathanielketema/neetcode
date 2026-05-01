/// Given an integer array nums, return all the
/// triplets [nums[i], nums[j], nums[k]] where nums[i] + nums[j] + nums[k] == 0,
/// and the indices i, j and k are all distinct.
///
/// The output should not contain any duplicate triplets. You may return the
/// output and the triplets in any order.
///
/// Example 1:
/// Input: nums = [-1,0,1,2,-1,-4]
/// Output: [[-1,-1,2],[-1,0,1]]
///
/// Explanation:
/// nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
/// nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
/// nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
/// The distinct triplets are [-1,0,1] and [-1,-1,2].
///
/// Example 2:
/// Input: nums = [0,1,1]
/// Output: []
///
/// Explanation: The only possible triplet does not sum up to 0.
///
/// Example 3:
/// Input: nums = [0,0,0]
/// Output: [[0,0,0]]
///
/// Explanation: The only possible triplet sums up to 0.
///
/// Constraints:
///     3 <= nums.length <= 1000
///     -10^5 <= nums[i] <= 10^5
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn three_sum(arena: Allocator, nums: []i32) ![][3]i32 {
        assert(nums.len >= 3 and nums.len <= 1000);
        std.mem.sort(i32, nums, {}, std.sort.asc(i32));

        var result: std.ArrayList([3]i32) = .empty;
        if (nums[0] > 0) return result.items;

        for (0..nums.len - 2) |i| {
            if (i != 0 and nums[i] == nums[i - 1]) continue;

            var lo: usize = i + 1;
            var hi: usize = nums.len - 1;
            while (lo < hi) {
                const sum = nums[i] + nums[lo] + nums[hi];
                switch (std.math.order(sum, 0)) {
                    .lt => lo += 1,
                    .gt => hi -= 1,
                    .eq => {
                        try result.append(arena, .{ nums[i], nums[lo], nums[hi] });
                        lo += 1;
                        hi -= 1;
                        while (lo < hi and nums[lo] == nums[lo + 1]) lo += 1;
                        while (lo < hi and nums[hi] == nums[hi - 1]) hi -= 1;
                    },
                }
            }
        }

        return result.items;
    }
};

test "solution" {
    const T = struct {
        fn check(nums: []const i32, want: []const [3]i32) !void {
            var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            defer arena_instance.deinit();
            const arena = arena_instance.allocator();

            const duped = try arena.dupe(i32, nums);

            const got = try Solution.three_sum(arena, duped);
            std.debug.print("{any}: {any}\n", .{ nums, got });
            try testing.expectEqual(want.len, got.len);
        }
    };

    try T.check(&.{ -1, 0, 1, 2, -1, -4 }, &.{ .{ -1, -1, 2 }, .{ -1, 0, 1 } });
    try T.check(&.{ 0, 1, 1 }, &.{});
    try T.check(&.{ 0, 0, 0 }, &.{.{ 0, 0, 0 }});
    try T.check(&.{ 0, 0, 0, 0 }, &.{.{ 0, 0, 0 }});
}
