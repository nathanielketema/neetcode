const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Allocator = std.mem.Allocator;

fn longest_consecutive_sequence(allocator: Allocator, nums: []const i64) usize {
    var seen: std.AutoArrayHashMap(i64, void) = .init(allocator);
    defer seen.deinit();

    for (nums) |num| {
        seen.put(num, {}) catch unreachable;
    }

    var longest: usize = 0;
    for (nums) |num| {
        if (!seen.contains(num - 1)) {
            var length: usize = 1;
            while (seen.contains(num + @as(i64, @intCast(length)))) {
                length += 1;
            }
            longest = @max(longest, length);
        }
    }

    return longest;
}

test "example" {
    const nums = [_]i64{ 2, 20, 4, 10, 3, 4, 5 };
    const result = longest_consecutive_sequence(testing.allocator, &nums);
    try testing.expectEqual(4, result);
}
