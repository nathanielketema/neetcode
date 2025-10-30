"""
Implement a time-based key-value data structure that supports:
    Storing multiple values for the same key at specified time stamps
    Retrieving the key's value at a specified timestamp

Implement the TimeMap class:
    TimeMap() Initializes the object.
    void set(String key, String value, int timestamp) Stores the key with the value at
    the given time timestamp.

    String get(String key, int timestamp) Returns the most recent value of key if set was
    previously called on it and the most recent timestamp for that key prev_timestamp is less
    than or equal to the given timestamp (prev_timestamp <= timestamp). If there are no values,
    it returns "".

Note: For all calls to set, the timestamps are in strictly increasing order.

Example 1:
Input = [
    "TimeMap",
    "set",
    ["alice", "happy", 1],
    "get",
    ["alice", 1],
    "get",
    ["alice", 2],
    "set",
    ["alice", "sad", 3],
    "get",
    ["alice", 3],
]
Output:
[null, null, "happy", "happy", null, "sad"]

Explanation:
TimeMap timeMap = new TimeMap();
timeMap.set("alice", "happy", 1);// store the key "alice" and value "happy" along with timestamp = 1.
timeMap.get("alice", 1);         // return "happy"
timeMap.get("alice", 2);         // return "happy", there is no value stored for timestamp 2, thus we return the value at timestamp 1.
timeMap.set("alice", "sad", 3);  // store the key "alice" and value "sad" along with timestamp = 3.
timeMap.get("alice", 3);        // return "sad"

Constraints:
    1 <= key.length, value.length <= 100
    key and value only include lowercase English letters and digits.
    1 <= timestamp <= 1000
"""


from collections import defaultdict


class TimeMap:

    def __init__(self):
        self.hash_map: defaultdict[str, list[tuple[str, int]]] = defaultdict(list)

        

    def set(self, key: str, value: str, timestamp: int) -> None:
        self.hash_map[key].append((value, timestamp))

        

    def get(self, key: str, timestamp: int) -> str:
        value_pairs = self.hash_map[key]
        left, right = 0, len(value_pairs) - 1

        while left <= right:
            mid = left + ((right - left) // 2)
            if value_pairs[mid][1] == timestamp:
                return value_pairs[mid][0]
            elif value_pairs[mid][1] < timestamp:
                left = mid + 1
            else:
                right = mid - 1
        found = ""
        for i in range(len(value_pairs) - 1, -1, -1):
            if value_pairs[i][1] < timestamp:
                found = value_pairs[i][0]
        return found

        

solution = TimeMap()

solution.set("alice", "happy", 1)
assert solution.get("alice", 1) == "happy"
assert solution.get("alice", 2) == "happy"

solution.set("alice", "sad", 3)
assert solution.get("alice", 3) == "sad"
