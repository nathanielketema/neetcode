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
    fn eval_RPN(arena: Allocator, tokens: []const []const u8) !i32 {
        assert(tokens.len >= 1);
        assert(tokens.len <= 1000);
        for (tokens) |token| {
            assert(std.mem.eql(u8, token, "+") or
                std.mem.eql(u8, token, "-") or
                std.mem.eql(u8, token, "*") or
                std.mem.eql(u8, token, "/") or
                try std.fmt.parseInt(i32, token, 10) >= -100 or
                try std.fmt.parseInt(i32, token, 10) <= 100);
        }

        const Operands = enum {
            @"+",
            @"-",
            @"*",
            @"/",
        };

        var stack: std.ArrayList(i32) = try .initCapacity(arena, tokens.len);
        for (tokens) |token| {
            const operands: Operands = std.meta.stringToEnum(Operands, token) orelse {
                try stack.append(arena, try std.fmt.parseInt(i32, token, 10));
                continue;
            };

            switch (operands) {
                .@"+" => {
                    const rhs = stack.pop().?;
                    const lhs = stack.pop().?;
                    try stack.append(arena, lhs + rhs);
                },
                .@"-" => {
                    const rhs = stack.pop().?;
                    const lhs = stack.pop().?;
                    try stack.append(arena, lhs - rhs);
                },
                .@"*" => {
                    const rhs = stack.pop().?;
                    const lhs = stack.pop().?;
                    try stack.append(arena, lhs * rhs);
                },
                .@"/" => {
                    const rhs = stack.pop().?;
                    const lhs = stack.pop().?;
                    try stack.append(arena, @divTrunc(lhs, rhs));
                },
            }
        }

        assert(stack.items.len == 1);
        return stack.pop().?;
    }
};

test "solution" {
    const T = struct {
        fn check(tokens: []const []const u8, want: i32) !void {
            var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            defer arena_instance.deinit();
            const arena = arena_instance.allocator();

            const got = try Solution.eval_RPN(arena, tokens);
            try testing.expectEqual(got, want);
        }
    };

    try T.check(&.{ "1", "2", "+", "3", "*", "4", "-" }, 5);
}
