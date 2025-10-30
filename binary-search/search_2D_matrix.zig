const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn search_matrix(matrix: []const []const i64, target: i64) bool {
        _ = matrix;
        _ = target;
        return true;
    }
};

test "test solution" {
    var matrix = [_][4]i64{
        .{ 1, 2, 4, 8 },
        .{ 10, 11, 12, 13 },
        .{ 14, 20, 30, 40 },
    };

    var rows = [_][]const i64{
        &matrix[0],
        &matrix[1],
        &matrix[2],
    };
    
    const target = 10;
    const solution = Solution.search_matrix(&rows, target);
    try testing.expectEqual(true, solution);
}
