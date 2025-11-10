"""
Reorder Linked List

You are given the head of a singly linked-list.

The positions of a linked list of length = 7 for example, can intially be represented as:
[0, 1, 2, 3, 4, 5, 6]

Reorder the nodes of the linked list to be in the following order:
[0, 6, 1, 5, 2, 4, 3]

Notice that in the general case for a list of length = n the nodes are reordered to be in 
the following order:
[0, n-1, 1, n-2, 2, n-3, ...]

You may not modify the values in the list's nodes, but instead you must reorder the nodes themselves.

Example 1:
Input: head = [2,4,6,8]
Output: [2,8,4,6]

Example 2:
Input: head = [2,4,6,8,10]
Output: [2,10,4,8,6]

Constraints:
    1 <= Length of the list <= 1000.
    1 <= Node.val <= 1000
"""

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

"""
class Solution:
    def reorderList(self, head: Optional[ListNode]) -> None:
        if not head:
            return

        nodes: list[ListNode] = []
        curr = head
        while curr:
            nodes.append(curr)
            curr = curr.next
        
        left, right = 0, len(nodes) - 1
        while left < right:
            nodes[left].next = nodes[right]
            left += 1

            if left >= right:
                break
            nodes[right].next = nodes[left]
            right -= 1
        
        nodes[left].next = None

        # Time: O(n)
        # Space: O(n)
"""

class Solution:
    def reorderList(self, head: Optional[ListNode]) -> None:
        if not head:
            return None

        # Find the half point of the list
        slow, fast = head, head.next
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next

        second, prev = slow.next, None
        slow.next = None
        # Reverse list
        while second:
            temp = second.next
            second.next = prev
            prev = second
            second = temp

        first, second = head, prev
        while second:
            temp1, temp2 = first.next, second.next
            first.next = second 
            second.next = temp1
            first, second = temp1, temp2

        # Time: O(n)
        # Space: O(1)
