"""
You are given an integer n. Return all well-formed parentheses strings that you can
generate with n pairs of parentheses.

Example 1:
Input: n = 1
Output: ["()"]

Example 2:
Input: n = 3
Output: ["((()))","(()())","(())()","()(())","()()()"]

You may return the answer in any order.

Constraints:
    1 <= n <= 7
"""


class Solution:
    def generateParenthesis(self, n: int) -> list[str]:
        result: list[str] = []
        stack: list[str] = []

        def backtrack(open_n: int, closed_n: int) -> None:
            if open_n == closed_n == n:
                result.append("".join(stack))
                return

            if open_n < n:
                stack.append("(")
                backtrack(open_n + 1, closed_n)
                _ = stack.pop()

            if closed_n < open_n:
                stack.append(")")
                backtrack(open_n, closed_n + 1)
                _ = stack.pop()

        backtrack(0, 0)
        return result

"""
def backtrack_iterative() -> None:
    call_stack = [(0, 0, [])]
    
    while call_stack:
        open_n, closed_n, current_stack = call_stack.pop()
        
        if open_n == closed_n == n:
            result.append("".join(current_stack))
            continue
        
        if closed_n < open_n:
            call_stack.append((open_n, closed_n + 1, current_stack + [")"]))
        
        if open_n < n:
            call_stack.append((open_n + 1, closed_n, current_stack + ["("]))
"""
