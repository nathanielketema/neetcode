/// Design a stack class that supports the push, pop, top, and getMin operations.
///
///     MinStack() initializes the stack object.
///     void push(int val) pushes the element val onto the stack.
///     void pop() removes the element on the top of the stack.
///     int top() gets the top element of the stack.
///     int getMin() retrieves the minimum element in the stack.
///
/// Each function should run in O(1) time.
///
/// Example 1:
/// Input: ["MinStack", "push", 1, "push", 2, "push", 0, "getMin", "pop", "top", "getMin"]
/// Output: [null,null,null,null,0,null,2,1]
///
/// Explanation:
/// MinStack minStack = new MinStack();
/// minStack.push(1);
/// minStack.push(2);
/// minStack.push(0);
/// minStack.getMin(); // return 0
/// minStack.pop();
/// minStack.top();    // return 2
/// minStack.getMin(); // return 1
///
/// Constraints:
///     -2^31 <= val <= 2^31 - 1.
///     pop, top and getMin will always be called on non-empty stacks.
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList(i32);

const Solution = struct {
    const MinStack = struct {
        stack: ArrayList,
        min_stack: ArrayList,
        arena: Allocator,

        const capacity: usize = 100;

        pub fn init(arena: Allocator) !MinStack {
            return .{
                .stack = try .initCapacity(arena, capacity),
                .min_stack = try .initCapacity(arena, capacity),
                .arena = arena,
            };
        }

        pub fn push(self: *MinStack, value: i32) !void {
            try self.stack.append(self.arena, value);
            try self.min_stack.append(self.arena, @min(
                value,
                self.min_stack.getLastOrNull() orelse std.math.maxInt(i32),
            ));
        }

        pub fn pop(self: *MinStack) void {
            assert(self.stack.items.len > 0);
            assert(self.min_stack.items.len > 0);

            _ = self.stack.pop();
            _ = self.min_stack.pop();
        }

        pub fn top(self: MinStack) i32 {
            assert(self.stack.items.len > 0);
            return self.stack.getLast();
        }

        pub fn get_min(self: MinStack) i32 {
            assert(self.min_stack.items.len > 0);
            return self.min_stack.getLast();
        }
    };
};

test "solution" {
    var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
    defer arena_instance.deinit();
    const arena = arena_instance.allocator();

    var stack: Solution.MinStack = try .init(arena);
    try stack.push(1);
    try stack.push(2);
    try stack.push(0);
    try testing.expectEqual(0, stack.get_min());
    stack.pop();
    try testing.expectEqual(2, stack.top());
    try testing.expectEqual(1, stack.get_min());
}
