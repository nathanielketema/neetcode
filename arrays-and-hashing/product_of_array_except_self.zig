/// Given an integer array nums, return an array output where output[i] is the product of
/// all the elements of nums except nums[i].
///
/// Each product is guaranteed to fit in a 32-bit integer.
///
/// Follow-up: Could you solve it in O(n) time without using the division operation?
///
/// Example 1:
/// Input: nums = [1,2,4,6]
/// Output: [48,24,12,8]
///
/// Example 2:
/// Input: nums = [-1,0,1,2,3]
/// Output: [0,-6,0,0,0]
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn product_except_self(arena: Allocator, nums: []const i32) ![]i32 {
        var product: []i32 = try arena.alloc(i32, nums.len);

        var prefix: i32 = 1;
        for (nums, 0..) |num, i| {
            product[i] = prefix;
            prefix *= num;
        }

        var postfix: i32 = 1;
        var i = nums.len;
        while (i > 0) {
            i -= 1;
            product[i] *= postfix;
            postfix *= nums[i];
        }

        return product;
    }
};

test "solution" {
    const T = struct {
        fn check(nums: []const i32, want: []const i32) !void {
            assert(nums.len == want.len);

            var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            defer arena_instance.deinit();
            const arena = arena_instance.allocator();

            const got = try Solution.product_except_self(arena, nums);
            try testing.expectEqualSlices(i32, want, got);

            std.debug.print("{any}: {any}\n", .{ nums, got });
        }
    };

    try T.check(&.{ 1, 2, 4, 6 }, &.{ 48, 24, 12, 8 });
    try T.check(&.{ -1, 0, 1, 2, 3 }, &.{ 0, -6, 0, 0, 0 });
}
