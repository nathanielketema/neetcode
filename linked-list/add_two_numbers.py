"""
You are given two non-empty linked lists, l1 and l2, where each represents a non-negative integer.

The digits are stored in reverse order, e.g. the number 321 is represented as 1 -> 2 -> 3 -> 
in the linked list.

Each of the nodes contains a single digit. You may assume the two numbers do not contain any 
leading zero, except the number 0 itself.

Return the sum of the two numbers as a linked list.

Example 1:
Input: l1 = [1,2,3], l2 = [4,5,6]
Output: [5,7,9]

Explanation: 321 + 654 = 975.

Example 2:
Input: l1 = [9], l2 = [9]
Output: [8,1]

Constraints:
    1 <= l1.length, l2.length <= 100.
    0 <= Node.val <= 9
"""

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next


# My solution
"""
class Solution:
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        prev, curr = None, l1
        while curr:
            temp = curr.next
            curr.next = prev
            prev = curr
            curr = temp
        l1 = prev
        
        curr = l1
        l1_str = ""
        while curr:
            l1_str += str(curr.val)
            curr = curr.next
        l1_val = int(l1_str)
        
        prev, curr = None, l2
        while curr:
            temp = curr.next
            curr.next = prev
            prev = curr
            curr = temp
        l2 = prev
        
        curr = l2
        l2_str = ""
        while curr:
            l2_str += str(curr.val)
            curr = curr.next
        l2_val = int(l2_str)
        
        total = l1_val + l2_val
        sum_str = str(total)
        
        dummy = ListNode(0)
        curr = dummy
        for i in range(len(sum_str) - 1, -1, -1):
            curr.next = ListNode(int(sum_str[i]))
            curr = curr.next
        
        return dummy.next
"""

class Solution:
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        dummy = ListNode()
        cur = dummy

        carry = 0
        while l1 or l2 or carry:
            v1 = l1.val if l1 else 0
            v2 = l2.val if l2 else 0

            val = v1 + v2 + carry
            carry = val // 10
            val = val % 10
            cur.next = ListNode(val)

            cur = cur.next
            l1 = l1.next if l1 else None
            l2 = l2.next if l2 else None

        return dummy.next
