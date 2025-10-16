"""
Valid Sudoku

You are given a 9 x 9 Sudoku board board. A Sudoku board is valid if the
following rules are followed:

    Each row must contain the digits 1-9 without duplicates.
    Each column must contain the digits 1-9 without duplicates.
    Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without duplicates.

Return true if the Sudoku board is valid, otherwise return false

Note: A board does not need to be full or be solvable to be valid.

Example 1:
Input: board =
[["1","2",".",".","3",".",".",".","."],
 ["4",".",".","5",".",".",".",".","."],
 [".","9","8",".",".",".",".",".","3"],
 ["5",".",".",".","6",".",".",".","4"],
 [".",".",".","8",".","3",".",".","5"],
 ["7",".",".",".","2",".",".",".","6"],
 [".",".",".",".",".",".","2",".","."],
 [".",".",".","4","1","9",".",".","8"],
 [".",".",".",".","8",".",".","7","9"]]

Output: true

Example 2:
Input: board =
[["1","2",".",".","3",".",".",".","."],
 ["4",".",".","5",".",".",".",".","."],
 [".","9","1",".",".",".",".",".","3"],
 ["5",".",".",".","6",".",".",".","4"],
 [".",".",".","8",".","3",".",".","5"],
 ["7",".",".",".","2",".",".",".","6"],
 [".",".",".",".",".",".","2",".","."],
 [".",".",".","4","1","9",".",".","8"],
 [".",".",".",".","8",".",".","7","9"]]
Output: false
Explanation: There are two 1's in the top-left 3x3 sub-box.

Constraints:
    board.length == 9
    board[i].length == 9
    board[i][j] is a digit 1-9 or '.'.
"""


class Solution:
    def isValidSudoku(self, board: list[list[str]]) -> bool:
        # Valid row
        for i in range(len(board)):
            seen: set[str] = set()
            for j in range(len(board[i])):
                if board[i][j] != ".":
                    if board[i][j] in seen:
                        return False
                    seen.add(board[i][j])

        # Valid col
        for j in range(len(board[0])):
            seen = set()
            for i in range(len(board)):
                if board[i][j] != ".":
                    if board[i][j] in seen:
                        return False
                    seen.add(board[i][j])

        # Valid square
        for i in range(0, len(board), 3):
            for j in range(0, len(board[i]), 3):
                seen = set()
                for row in range(i, i + 3):
                    for col in range(j, j + 3):
                        if board[row][col] != ".":
                            if board[row][col] in seen:
                                return False
                            seen.add(board[row][col])

        return True
