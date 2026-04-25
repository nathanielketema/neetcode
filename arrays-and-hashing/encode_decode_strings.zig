/// Design an algorithm to encode a list of strings to a single string.
/// The encoded string is then decoded back to the original list of strings.
///
/// Given an integer array nums, return true if any value appears more than once in the array,
/// otherwise return false.
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn encode(arena: Allocator, strings: []const []const u8) ![]const u8 {
        var encoded: std.ArrayList(u8) = try .initCapacity(arena, strings.len * 2);
        for (strings) |string| {
            try encoded.print(arena, "{d}", .{string.len});
            try encoded.append(arena, '#');
            try encoded.appendSlice(arena, string);
        }
        return encoded.items;
    }

    fn decode(arena: Allocator, string: []const u8) ![]const []const u8 {
        var decoded: std.ArrayList([]const u8) = try .initCapacity(arena, string.len);

        var i: usize = 0;
        var j: usize = 0;
        while (j < string.len) {
            while (string[j] != '#') : (j += 1) {}
            const count = try std.fmt.parseInt(usize, string[i..j], 10);
            j += 1;
            try decoded.append(arena, string[j .. j + count]);
            j += count;
            i = j;
        }
        return decoded.items;
    }
};

test "solution" {
    const T = struct {
        fn check(strings: []const []const u8) !void {
            var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            defer arena_instance.deinit();
            const arena = arena_instance.allocator();

            const encoded = try Solution.encode(arena, strings);
            const decoded = try Solution.decode(arena, encoded);
            assert(strings.len == decoded.len);

            for (strings, decoded) |str, dec| {
                try testing.expectEqualStrings(str, dec);
            }

            std.debug.print("\"{s}\"\n", .{encoded});
            std.debug.print("[", .{});
            for (decoded) |d| {
                std.debug.print(" \"{s}\",", .{d});
            }
            std.debug.print("]\n", .{});
        }
    };

    try T.check(&.{
        "neet",
        "code",
        "loves",
        "you",
        "",
        "thisIsAVeryLongStringToCheckForInVariant",
    });
    try T.check(&.{ "neet", "code", "love", "you" });
    try T.check(&.{ "we", "say", ":", "yes" });
    try T.check(&.{ "2#we", "fo2#", "###", "yes!" });
}
