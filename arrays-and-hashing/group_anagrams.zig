/// Given an array of strings strs, group all anagrams together into sublists.
/// You may return the output in any order.
///
/// An anagram is a string that contains the exact same characters as another string,
/// but the order of the characters can be different.
///
///
/// Example 1:
/// Input: strs = ["act","pots","tops","cat","stop","hat"]
/// Output: [["hat"],["act", "cat"],["stop", "pots", "tops"]]
///
/// Example 2:
/// Input: strs = ["x"]
/// Output: [["x"]]
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn group_anagrams(arena: Allocator, strings: []const []const u8) ![][]const []const u8 {
        var final: std.ArrayList([]const []const u8) = try .initCapacity(arena, strings.len);
        var anagrams: std.AutoHashMap([26]u8, std.ArrayList([]const u8)) = .init(arena);

        for (strings) |string| {
            const freq_count: [26]u8 = b: {
                var freq: [26]u8 = .{0} ** 26;
                for (string) |char| freq[char - 'a'] += 1;
                break :b freq;
            };

            const result = try anagrams.getOrPut(freq_count);
            if (result.found_existing) {
                try result.value_ptr.*.append(arena, string);
            } else {
                result.value_ptr.* = try .initCapacity(arena, string.len);
                try result.value_ptr.*.append(arena, string);
            }
        }

        var it = anagrams.valueIterator();
        while (it.next()) |grp| {
            try final.append(arena, grp.items);
        }
        return final.items;
    }
};

test "solution" {
    const T = struct {
        fn check(strings: []const []const u8, count: usize) !void {
            var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            defer arena_instance.deinit();
            const arena = arena_instance.allocator();

            const group = try Solution.group_anagrams(arena, strings);
            try testing.expectEqual(count, group.len);

            std.debug.print("[", .{});
            for (strings) |str| {
                std.debug.print(" \"{s}\", ", .{str});
            }
            std.debug.print("]: ", .{});

            std.debug.print("[", .{});
            for (group) |grp| {
                std.debug.print(" [", .{});
                for (grp) |str| {
                    std.debug.print(" \"{s}\", ", .{str});
                }
                std.debug.print("],", .{});
            }
            std.debug.print("]\n", .{});
        }
    };

    try T.check(&.{ "act", "pots", "tops", "cat", "stop", "hat" }, 3);
    try T.check(&.{}, 0);
    try T.check(&.{ "a", "b", "c" }, 3);
    try T.check(&.{ "a", "a", "a" }, 1);
}
