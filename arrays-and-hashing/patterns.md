# Arrays and Hashing

1. Use hash sets for when you're working with duplicates

   ```python
   seen = set()
   for item in items:
       if item in seen:
           duplicate = True
       seen.add(item)
   ```

2. Encoding a list of strings:
   - Add a delimeter and the length of each string

   ```markdown
   Given: ["hello", "world", "!"]
   Encoding: "5#hello5#world1#!"
   ```

   - To decode this just use two pointers

3. Group Anagrams:
   - Whenever the brute force way is O(n^2), try to come up with a property that you can use
     through a hashmap. In this case the property was the count of charachters in the strings.

   ```python
   # python does not allow lists to be used as keys for dictionaries
    """
            Table
    freq_count : list[str]
    [0..26]    : ["", ""]
    """
   ```

   - Anagrams are just permutations

4. Longest Consecutive Sequence
   - There are things where you can't avoid going through the entire array O(n). So then what you
     to think about is after O(n), how can I avoid going through the list again. Again thinking
     about properties and using a hash map is a great solution

   - For this problem the properties were:
     - only start counting for numbers that can be the start of a sequence

       ```python
       if (num - 1) not in seen:
       ```

5. Product Except Self
   - Always think about the property of the problem. Imagine you're writing a property test for a
     given problem.

   - A property of this problem is that `result[i]` is the product of the left times the product
     of the right values

   - Another property is that `result[i]` is the product of all values other than `num[i]`
     divided by `nums[i]`:
     - what happens when's there is a zero
     - what happens when there are two zeros

6. Top k frequent elements
   - Bucket sort for O(n) because frequency is capped at `len(nums)`



