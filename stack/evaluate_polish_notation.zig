/// You are given an array of strings tokens that represents a valid arithmetic expression
/// in Reverse Polish Notation.
///
/// Return the integer that represents the evaluation of the expression.
///
///     The operands may be integers or the results of other operations.
///     The operators include '+', '-', '*', and '/'.
///     Assume that division between integers always truncates toward zero.
///
/// Example 1:
///
/// Input: tokens = ["1","2","+","3","*","4","-"]
/// Output: 5
/// Explanation: ((1 + 2) * 3) - 4 = 5
///
/// Constraints:
///     1 <= tokens.length <= 1000.
///     tokens[i] is "+", "-", "*", or "/", or a string representing an integer in the range [-100, 100].
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn eval_RPN(tokens: [][]const u8) i32 {}
};

test "solution" {
    const T = struct {
        fn check(tokens: [][]const u8, want: i32) !void {
            //var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            //defer arena_instance.deinit();
            //const arena = arena_instance.allocator();

            const got = Solution.eval_RPN(tokens);
            std.debug.print("{any}: {any}\n", .{ tokens, got });
            try testing.expectEqual(got, want);
        }
    };

    try T.check(&.{ "1", "2", "+", "3", "*", "4", "-" }, 5);
}
