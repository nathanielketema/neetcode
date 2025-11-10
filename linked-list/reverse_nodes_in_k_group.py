"""
You are given the head of a singly linked list head and a positive integer k.

You must reverse the first k nodes in the linked list, and then reverse the next k nodes, 
and so on. If there are fewer than k nodes left, leave the nodes as they are.

Return the modified list after reversing the nodes in each group of k.

You are only allowed to modify the nodes' next pointers, not the values of the nodes.

Example 1:
Input: head = [1,2,3,4,5,6], k = 3
Output: [3,2,1,6,5,4]

Example 2:
Input: head = [1,2,3,4,5], k = 3
Output: [3,2,1,4,5]

Constraints:
    The length of the linked list is n.
    1 <= k <= n <= 100
    0 <= Node.val <= 100
"""

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

class Solution:
    def reverseKGroup(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        stack: list[ListNode] = []
        dummy = ListNode()
        prev = dummy

        curr = head
        while curr:
            for _ in range(k):
                if not curr:
                    break
                stack.append(curr)
                curr = curr.next

            if len(stack) == k:
                while stack:
                    prev.next = stack.pop()
                    prev = prev.next
            else:
                for node in stack:
                    prev.next = node
                    prev = prev.next
                stack.clear()
        prev.next = None
        return dummy.next
"""
The time complexity is O(n) where n is the number of nodes in the linked list.

The outer while curr: loop processes each node exactly once
The inner for _ in range(k): loop adds nodes to the stack - each node is pushed once
The while stack: or for node in stack: pops/iterates through nodes - each node is popped once
Stack operations (push/pop) are O(1)

So each node is:

Visited once (pushed to stack)
Processed once (popped from stack or iterated)

Total: O(n)
Space complexity: O(k) for the stack, since at most k nodes are stored at any time.
"""


# A better solution
class Solution2:
    def reverseKGroup(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        dummy = ListNode(0, head)
        groupPrev = dummy

        while True:
            kth = self.getKth(groupPrev, k)
            if not kth:
                break
            groupNext = kth.next

            prev, curr = kth.next, groupPrev.next
            while curr != groupNext:
                tmp = curr.next
                curr.next = prev
                prev = curr
                curr = tmp

            tmp = groupPrev.next
            groupPrev.next = kth
            groupPrev = tmp
        return dummy.next

    def getKth(self, curr, k):
        while curr and k > 0:
            curr = curr.next
            k -= 1
        return curr
