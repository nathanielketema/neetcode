/// Valid Sudoku
///
/// You are given a 9 x 9 Sudoku board board. A Sudoku board is valid if the
/// following rules are followed:
///
///     Each row must contain the digits 1-9 without duplicates.
///     Each column must contain the digits 1-9 without duplicates.
///     Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without duplicates.
///
/// Return true if the Sudoku board is valid, otherwise return false
///
/// Note: A board does not need to be full or be solvable to be valid.
///
/// Example 1:
/// Input: board =
/// [["1","2",".",".","3",".",".",".","."],
///  ["4",".",".","5",".",".",".",".","."],
///  [".","9","8",".",".",".",".",".","3"],
///  ["5",".",".",".","6",".",".",".","4"],
///  [".",".",".","8",".","3",".",".","5"],
///  ["7",".",".",".","2",".",".",".","6"],
///  [".",".",".",".",".",".","2",".","."],
///  [".",".",".","4","1","9",".",".","8"],
///  [".",".",".",".","8",".",".","7","9"]]
///
/// Output: true
///
/// Example 2:
/// Input: board =
/// [["1","2",".",".","3",".",".",".","."],
///  ["4",".",".","5",".",".",".",".","."],
///  [".","9","1",".",".",".",".",".","3"],
///  ["5",".",".",".","6",".",".",".","4"],
///  [".",".",".","8",".","3",".",".","5"],
///  ["7",".",".",".","2",".",".",".","6"],
///  [".",".",".",".",".",".","2",".","."],
///  [".",".",".","4","1","9",".",".","8"],
///  [".",".",".",".","8",".",".","7","9"]]
/// Output: false
/// Explanation: There are two 1's in the top-left 3x3 sub-box.
///
/// Constraints:
///     board.length == 9
///     board[i].length == 9
///     board[i][j] is a digit 1-9 or '.'.
const std = @import("std");
const assert = std.debug.assert;
const testing = std.testing;

const Io = std.Io;
const Allocator = std.mem.Allocator;

const Solution = struct {
    fn is_valid_sudoku(arena: Allocator, board: [9][9][]const u8) !bool {
        var seen: std.StringHashMap(void) = .init(arena);
        for (0..9) |r| {
            seen.clearRetainingCapacity();
            for (0..9) |c| {
                const cell = board[r][c];
                if (!std.mem.eql(u8, cell, ".")) {
                    if (seen.contains(cell)) return false;
                    try seen.put(cell, {});
                }
            }
        }

        for (0..9) |c| {
            seen.clearRetainingCapacity();
            for (0..9) |r| {
                const cell = board[r][c];
                if (!std.mem.eql(u8, cell, ".")) {
                    if (seen.contains(cell)) return false;
                    try seen.put(cell, {});
                }
            }
        }

        var i: usize = 0;
        var j: usize = 0;
        while (i < 9) : (i += 3) {
            j = 0;
            while (j < 9) : (j += 3) {
                seen.clearRetainingCapacity();
                for (0..3) |r| {
                    for (0..3) |c| {
                        const cell = board[r + i][c + j];
                        if (!std.mem.eql(u8, cell, ".")) {
                            if (seen.contains(cell)) return false;
                            try seen.put(cell, {});
                        }
                    }
                }
            }
        }

        return true;
    }
};

test "solution" {
    const T = struct {
        fn check(board: [9][9][]const u8, want: bool) !void {
            var arena_instance: std.heap.ArenaAllocator = .init(testing.allocator);
            defer arena_instance.deinit();
            const arena = arena_instance.allocator();

            const got = try Solution.is_valid_sudoku(arena, board);
            try testing.expectEqual(want, got);
        }
    };

    try T.check(.{
        .{ "1", "2", ".", ".", "3", ".", ".", ".", "." },
        .{ "4", ".", ".", "5", ".", ".", ".", ".", "." },
        .{ ".", "9", "8", ".", ".", ".", ".", ".", "3" },
        .{ "5", ".", ".", ".", "6", ".", ".", ".", "4" },
        .{ ".", ".", ".", "8", ".", "3", ".", ".", "5" },
        .{ "7", ".", ".", ".", "2", ".", ".", ".", "6" },
        .{ ".", ".", ".", ".", ".", ".", "2", ".", "." },
        .{ ".", ".", ".", "4", "1", "9", ".", ".", "8" },
        .{ ".", ".", ".", ".", "8", ".", ".", "7", "9" },
    }, true);
}
