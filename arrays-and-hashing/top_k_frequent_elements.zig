/// Given an integer array nums and an integer k, return the k most frequent elements within the array.
///
/// The test cases are generated such that the answer is always unique.
///
/// You may return the output in any order.
///
///
/// Example 1:
/// Input: nums = [1,2,2,3,3,3], k = 2
/// Output: [2,3]
///
/// Example 2:
/// Input: nums = [7,7], k = 1
/// Output: [7]
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn top_k_frequent(arena: Allocator, nums: []const i32, k: usize) ![]i32 {
        var freq_count: std.AutoHashMap(i32, usize) = .init(arena);
        for (nums) |num| {
            const result = try freq_count.getOrPut(num);
            if (result.found_existing) {
                result.value_ptr.* += 1;
            } else {
                result.value_ptr.* = 1;
            }
        }

        var bucket: []std.ArrayList(i32) = try arena.alloc(std.ArrayList(i32), nums.len + 1);
        for (bucket) |*array| {
            array.* = try std.ArrayList(i32).initCapacity(arena, nums.len);
        }

        var it = freq_count.iterator();
        while (it.next()) |item| {
            try bucket[item.value_ptr.*].append(arena, item.key_ptr.*);
        }

        var final: std.ArrayList(i32) = try .initCapacity(arena, nums.len);
        var i = bucket.len;
        while (i > k) {
            i -= 1;
            try final.appendSlice(arena, bucket[i].items);
        }

        return final.items;
    }
};

test "solution" {
    const T = struct {
        fn check(nums: []const i32, k: usize, want: []const i32) !void {
            var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            defer arena_instance.deinit();
            const arena = arena_instance.allocator();

            const got = try Solution.top_k_frequent(arena, nums, k);
            try testing.expectEqual(want.len, got.len);

            std.debug.print("{any}: {any}\n", .{ nums, got });
        }
    };

    try T.check(&.{ 1, 2, 2, 3, 3, 3, 4, 4 }, 2, &.{ 2, 4, 3 });
    try T.check(&.{ 7, 7 }, 1, &.{7});
    try T.check(&.{ 1, 2, 3, 4 }, 1, &.{ 1, 2, 3, 4 });
    try T.check(&.{ 1, 1, 2, 3, 4 }, 5, &.{});
}
