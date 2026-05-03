///  There are n cars traveling to the same destination on a one-lane highway.
///
///  You are given two arrays of integers position and speed, both of length n.
///
///      position[i] is the position of the ith car (in miles)
///      speed[i] is the speed of the ith car (in miles per hour)
///
///  The destination is at position target miles.
///
///  A car can not pass another car ahead of it. It can only catch up to another car
///  and then drive at the same speed as the car ahead of it.
///
///  A car fleet is a non-empty set of cars driving at the same position and same speed.
///  A single car is also considered a car fleet.
///
///  If a car catches up to a car fleet the moment the fleet reaches the destination,
///  then the car is considered to be part of the fleet.
///
///  Return the number of different car fleets that will arrive at the destination.
///
///  Example 1:
///  Input: target = 10, position = [1,4], speed = [3,2]
///  Output: 1
///
///  Explanation: The cars starting at 1 (speed 3) and 4 (speed 2) become a fleet,
///  meeting each other at 10, the destination.
///
///  Example 2:
///  Input: target = 10, position = [4,1,0,7], speed = [2,2,1,1]
///  Output: 3
///
///  Explanation: The cars starting at 4 and 7 become a fleet at position 10. The
///  cars starting at 1 and 0 never catch up to the car ahead of them. Thus, there
///  are 3 car fleets that will arrive at the destination.
///
///  Constraints:
///      n == position.length == speed.length.
///      1 <= n <= 1000
///      0 < target <= 1000
///      0 < speed[i] <= 100
///      0 <= position[i] < target
///      All the values of position are unique.
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn car_fleet(arena: Allocator, target: u32, position: []u32, speed: []const u32) !usize {
        assert(position.len == speed.len);
        assert(target > 0 and target <= 1000);
        for (position, speed, 0..) |po, sp, i| {
            assert(po < target);
            assert(sp > 0 and sp <= 100);
            if (i < position.len - 1) assert(position[i] != position[i + 1]);
        }

        const Car = struct {
            position: u32,
            speed: u32,
        };

        var cars: []Car = try arena.alloc(Car, position.len);
        for (position, speed, 0..) |po, sp, i| {
            cars[i] = Car{
                .position = po,
                .speed = sp,
            };
        }
        std.mem.sort(Car, cars, {}, struct {
            fn greater_than(_: void, lhs: Car, rhs: Car) bool {
                return std.math.order(lhs.position, rhs.position) == .gt;
            }
        }.greater_than);

        var stack: std.ArrayList(f64) = try .initCapacity(arena, position.len);
        for (cars) |car| {
            const time = @as(f64, @floatFromInt(target - car.position)) /
                @as(f64, @floatFromInt(car.speed));

            if (stack.getLastOrNull()) |item| {
                if (time > item) try stack.append(arena, time);
            } else {
                try stack.append(arena, time);
            }
        }

        return stack.items.len;
    }
};

test "solution" {
    const T = struct {
        fn check(target: u32, position: []const u32, speed: []const u32, want: usize) !void {
            var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            defer arena_instance.deinit();
            const arena = arena_instance.allocator();

            const duped_position = try arena.dupe(u32, position);

            const got = try Solution.car_fleet(arena, target, duped_position, speed);
            std.debug.print("target = {d}, position = {any}, speed: {any} -> {d}\n", .{
                target,
                position,
                speed,
                got,
            });
            try testing.expectEqual(want, got);
        }
    };

    try T.check(10, &.{ 4, 1, 0, 7 }, &.{ 2, 2, 1, 1 }, 3);
}
