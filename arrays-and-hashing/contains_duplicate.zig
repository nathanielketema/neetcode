const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

fn has_duplicate(nums: []const u8) !bool {
    var seen: std.AutoHashMap(u8, void) = .init(testing.allocator);
    defer seen.deinit();
    for (nums) |num| {
        if (seen.contains(num)) {
            return true;
        }
        try seen.put(num, {});
    }
    return false;
}


test "solution" {
    const nums = [_]u8{2, 1, 3, 2};
    try testing.expect(try has_duplicate(&nums));
}
