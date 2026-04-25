/// Given an array of integers nums and an integer target, return the indices i and j such
/// that nums[i] + nums[j] == target and i != j.
///
/// You may assume that every input has exactly one pair of indices i and j that satisfy the condition.
///
/// Return the answer with the smaller index first.
///
/// Input:
/// nums = [3,4,5,6], target = 7
/// Output: [0,1]
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn two_sum(arena: Allocator, nums: []const i32, target: i32) ![2]usize {
        var diff_index: std.AutoHashMap(i32, usize) = .init(arena);
        for (nums, 0..) |num, i| {
            const diff = target - num;
            if (diff_index.contains(diff)) {
                const index = diff_index.get(diff).?;
                return .{index, i};
            }
            try diff_index.put(num, i);
        }

        // Based on the instruction
        unreachable;
    }
};

test "solution" {
    const T = struct {
        fn check(nums: []const i32, target: i32, want: [2]usize) !void {
            var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            defer arena_instance.deinit();
            const arena = arena_instance.allocator();

            const got = try Solution.two_sum(arena, nums, target);
            try testing.expectEqual(want, got);

            std.debug.print("{any}: {any}\n", .{ nums, got });
        }
    };

    try T.check(&.{ 3, 4, 5, 6 }, 7, .{ 0, 1 });
}
