/// Given an array of integers numbers that is sorted in non-decreasing order.
///
/// Return the indices (1-indexed) of two numbers, [index1, index2], such that they add
/// up to a given target number target and index1 < index2. Note that index1 and index2
/// cannot be equal, therefore you may not use the same element twice.
///
/// There will always be exactly one valid solution.
///
/// Your solution must use O(1) additional space.
///
/// Example 1:
/// Input: numbers = [1,2,3,4], target = 3
/// Output: [1,2]
///
/// Explanation:
/// The sum of 1 and 2 is 3. Since we are assuming a 1-indexed array, index1 = 1, index2 = 2.
/// We return [1, 2].
///
/// Constraints:
///     2 <= numbers.length <= 1000
///     -1000 <= numbers[i] <= 1000
///     -1000 <= target <= 1000
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn two_sum(numbers: []const i32, target: i32) [2]usize {
        assert(numbers.len >= 2);
        assert(numbers.len <= 1000);
        assert(target >= -1000);
        assert(target <= 1000);
        for (numbers, 0..) |number, i| {
            assert(number >= -1000);
            assert(number <= 1000);
            if (i < numbers.len - 1) assert(numbers[i] <= numbers[i + 1]);
        }

        var lo: usize = 0;
        var hi: usize = numbers.len - 1;
        while (lo < hi) {
            const sum = numbers[lo] + numbers[hi];
            switch (std.math.order(sum, target)) {
                .lt => lo += 1,
                .gt => hi -= 1,
                .eq => return .{ lo + 1, hi + 1 },
            }
        }

        unreachable; // per instruction
    }
};

test "solution" {
    const T = struct {
        fn check(numbers: []const i32, target: i32, want: [2]usize) !void {
            const got = Solution.two_sum(numbers, target);
            std.debug.print("{any}, {d}: {any}\n", .{ numbers, target, got });
            try testing.expectEqual(want, got);
        }
    };

    try T.check(&.{ 1, 2, 3, 4 }, 3, .{ 1, 2 });
}
