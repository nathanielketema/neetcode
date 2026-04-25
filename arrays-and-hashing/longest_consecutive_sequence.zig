/// Longest Consecutive Sequence
///
/// Given an array of integers nums, return the length of the longest consecutive sequence of elements
/// that can be formed.
///
/// A consecutive sequence is a sequence of elements in which each element is exactly 1 greater than
/// the previous element. The elements do not have to be consecutive in the original array.
///
/// You must write an algorithm that runs in O(n) time.
///
/// Example 1:
/// Input: nums = [2,20,4,10,3,4,5]
/// Output: 4
/// Explanation: The longest consecutive sequence is [2, 3, 4, 5].
///
/// Example 2:
/// Input: nums = [0,3,2,5,4,6,1,1]  -> [0,1,1,2,3,4,5,6]
/// Output: 7
///
/// Constraints:
///     0 <= nums.length <= 1000
///     -10^9 <= nums[i] <= 10^9
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn longest_consecutive(arena: Allocator, nums: []const i8) !usize {
        var seen: std.AutoHashMap(i8, void) = .init(arena);
        for (nums) |num| try seen.put(num, {});

        var longest: usize = 0;
        for (nums) |num| {
            if (!seen.contains(num - 1)) {
                var long: usize = 0;
                var i: i8 = 0;
                while (seen.contains(num + i)) : (i += 1) {
                    long += 1;
                }
                longest = @max(longest, long);
            }
        }

        return longest;
    }
};

test "solution" {
    const T = struct {
        fn check(nums: []const i8, count: usize) !void {
            var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            defer arena_instance.deinit();
            const arena = arena_instance.allocator();

            const longest = try Solution.longest_consecutive(arena, nums);
            try testing.expectEqual(count, longest);

            std.debug.print("{any}: {d}\n", .{ nums, longest });
        }
    };

    try T.check(&.{ 2, 20, 4, 10, 3, 4, 5 }, 4);
    try T.check(&.{}, 0);
    try T.check(&.{ 0, 3, 2, 5, 4, 6, 1, 1 }, 7);
}
