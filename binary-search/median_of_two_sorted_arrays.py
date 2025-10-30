"""
You are given two integer arrays nums1 and nums2 of size m and n respectively, 
where each is sorted in ascending order. Return the median value among all elements 
of the two arrays.

Your solution must run in O(log(m+n)) time.

Example 1:
Input: nums1 = [1,2], nums2 = [3]
Output: 2.0

Explanation: Among [1, 2, 3] the median is 2.

Example 2:
Input: nums1 = [1,3], nums2 = [2,4]
Output: 2.5

Explanation: Among [1, 2, 3, 4] the median is (2 + 3) / 2 = 2.5.

Constraints:
    nums1.length == m
    nums2.length == n
    0 <= m <= 1000
    0 <= n <= 1000
    -10^6 <= nums1[i], nums2[i] <= 10^6
"""

class Solution:
    def findMedianSortedArrays(self, nums1: list[int], nums2: list[int]) -> float:
        a, b = nums1, nums2
        total = len(nums1) + len(nums2)
        half = total // 2

        if len(b) < len(a):
            a, b = b, a

        left, right = 0, len(a) - 1
        while True:
            i = (left + right) // 2
            j = half - i - 2

            Aleft = a[i] if i >= 0 else float("-infinity")
            Aright = a[i + 1] if (i + 1) < len(a) else float("infinity")
            Bleft = b[j] if j >= 0 else float("-infinity")
            Bright = b[j + 1] if (j + 1) < len(b) else float("infinity")

            if Aleft <= Bright and Bleft <= Aright:
                if total % 2:
                    return min(Aright, Bright)
                return (max(Aleft, Bleft) + min(Aright, Bright)) / 2
            elif Aleft > Bright:
                right = i - 1
            else:
                left = i + 1

solution = Solution()
nums1, nums2 = [2, 4, 6, 8], [1, 3, 5, 7]
assert solution.findMedianSortedArrays(nums1, nums2) == 4.5

nums1, nums2 = [1,2], [3]
assert solution.findMedianSortedArrays(nums1, nums2) == 2.0
