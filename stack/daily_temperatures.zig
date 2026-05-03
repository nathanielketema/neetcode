/// You are given an array of integers temperatures where temperatures[i] represents
/// the daily temperatures on the ith day.
///
/// Return an array result where result[i] is the number of days after the ith day
/// before a warmer temperature appears on a future day. If there is no day in the
/// future where a warmer temperature will appear for the ith day, set result[i] to 0 instead.
///
/// Example 1:
/// Input: temperatures = [30,38,30,36,35,40,28]
/// Output: [1,4,1,2,1,0,0]
///
/// Example 2:
/// Input: temperatures = [22,21,20]
/// Output: [0,0,0]
///
/// Constraints:
///     1 <= temperatures.length <= 1000.
///     1 <= temperatures[i] <= 100
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn daily_temperatures(arena: Allocator, temperatures: []const i32) ![]usize {
        assert(temperatures.len >= 1);
        assert(temperatures.len <= 1000);
        for (temperatures) |temperature| {
            assert(temperature >= 1);
            assert(temperature <= 100);
        }

        const TempIndex = struct {
            index: usize,
            temp: i32,
        };

        var result: []usize = try arena.alloc(usize, temperatures.len);
        @memset(result, 0);

        var stack: std.ArrayList(TempIndex) = try .initCapacity(arena, temperatures.len);
        for (temperatures, 0..) |temp, i| {
            while (stack.getLastOrNull()) |pair| {
                if (temp <= pair.temp) break;

                const index = stack.pop().?.index;
                result[index] = i - index;
            } 
            try stack.append(arena, .{ .index = i, .temp = temp });
        }

        return result;
    }
};

test "solution" {
    const T = struct {
        fn check(temperatures: []const i32, want: []const usize) !void {
            var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            defer arena_instance.deinit();
            const arena = arena_instance.allocator();

            const got = try Solution.daily_temperatures(arena, temperatures);
            std.debug.print("{any}: {any}\n", .{ temperatures, got });
            try testing.expectEqualSlices(usize, want, got);
        }
    };

    try T.check(&.{ 30, 38, 30, 36, 35, 40, 28 }, &.{ 1, 4, 1, 2, 1, 0, 0 });
    try T.check(&.{ 22, 21, 20 }, &.{ 0, 0, 0 });
}
