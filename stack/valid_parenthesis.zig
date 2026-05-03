/// You are given a string s consisting of the following characters: '(', ')', '{', '}', '[' and ']'.
///
/// The input string s is valid if and only if:
///     Every open bracket is closed by the same type of close bracket.
///     Open brackets are closed in the correct order.
///     Every close bracket has a corresponding open bracket of the same type.
///
/// Return true if s is a valid string, and false otherwise.
///
/// Example 1:
/// Input: s = "[]"
/// Output: true
///
/// Example 2:
/// Input: s = "([{}])"
/// Output: true
///
/// Example 3:
/// Input: s = "[(])"
/// Output: false
///
/// Explanation: The brackets are not closed in the correct order.
///
/// Constraints:
///     1 <= s.length <= 1000
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn is_valid(arena: Allocator, s: []const u8) !bool {
        assert(s.len >= 1);
        assert(s.len <= 1000);

        var stack: std.ArrayList(u8) = try .initCapacity(arena, s.len);
        for (s) |c| {
            switch (c) {
                '(', '[', '{' => try stack.append(arena, c),
                ')', ']', '}' => {
                    const have: u8 = stack.pop() orelse return false;
                    const want: u8 = switch (c) {
                        ')' => '(',
                        ']' => '[',
                        '}' => '{',
                        else => unreachable,
                    };

                    if (have != want) return false;
                },
                else => return false,
            }
        }

        return stack.items.len == 0;
    }
};

test "solution" {
    const T = struct {
        fn check(s: []const u8, want: bool) !void {
            var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            defer arena_instance.deinit();
            const arena = arena_instance.allocator();

            const got = try Solution.is_valid(arena, s);
            std.debug.print("{s}: {any}\n", .{ s, got });
            try testing.expectEqual(want, got);
        }
    };

    try T.check("[]", true);
    try T.check("([{}])", true);
    try T.check("[(])", false);
    try T.check("()[]{}[()]", true);
}
