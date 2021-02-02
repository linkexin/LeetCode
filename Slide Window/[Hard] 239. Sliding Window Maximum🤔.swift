// faster than 79.49%, less than 100.00%
// 维护一个单调队列，所谓单调队列，也就是队列中的元素是递增或者递减的，这题中我们要维护单调递减队列
// window 中存的是下标，这点很重要，如果不存下标，这题是没法用单调队列来实现的
// 这题可以不使用堆来实现是因为求解的是最大值，而不是第k大值之类的
// https://leetcode-cn.com/problems/sliding-window-maximum/solution/shuang-duan-dui-lie-jie-jue-hua-dong-chuang-kou--2/ 题解中的图画的比较清晰
// https://leetcode.com/problems/sliding-window-maximum/discuss/65884/Java-O(n)-solution-using-deque-with-explanation 用文字解释了单调队列
class Solution {
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        guard nums.count > 0 else {
            return []
        }
        var result = [Int](), window = [Int]()
        // 先初始化前 k 个元素
        for i in 0 ..< k {
            // 后入队的元素比先入队的元素大，那么只要后入队的元素存在，先入队的元素就不可能是最大值，所以直接 pop 就可以
            // 注意这里是从后往前比较
            while !window.isEmpty && nums[window.last!] < nums[i] {
                window.removeLast()
            }
            window.append(i)
        }
        result.append(nums[window[0]])
        
        for i in k ..< nums.count {
            // 如果超过窗口大小了，先 pop 出最前端元素
            if !window.isEmpty && window[0] <= i - k {
                window.removeFirst()
            }
            // 和上面一样，从后往前比较
            while !window.isEmpty && nums[window.last!] < nums[i] {
                window.removeLast()
            }
            window.append(i)
            // 每次处理完以后，队头元素就是当前最大值
            result.append(nums[window[0]])
        }
        
        return result
        
    }
}

// 2021-02-02 window 存放下标是因为需要通过下标判断元素是否还在滑动窗口范围内
// 将上面两个循环合并一下：
class Solution {
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        guard nums.count > 0 && k > 0 else {
            return []
        }
        var window = [Int]() // 存放下标
        var result = [Int]()
        
        for i in 0 ..< nums.count {
            // 当下标 <= i - k 时表示最开头的元素已经不在窗口范围内了，直接移除掉
            if !window.isEmpty && window.first! <= i - k {
                window.removeFirst()
            }
            while !window.isEmpty && nums[window.last!] < nums[i] {
                window.removeLast()
            }
            window.append(i)
            if i >= k - 1 { // 这里加个限制条件即可
                result.append(nums[window.first ?? 0])
            }
        }
        return result
    }
}

let s = Solution()
print(s.maxSlidingWindow([1,3,-1,-3,5,3,6,7], 3))//[3,3,5,5,6,7]
print(s.maxSlidingWindow([1,3,-1,-3,5,3,6,7], 4))//[3, 5, 5, 6, 7]
print(s.maxSlidingWindow([1,3,1,2,0,5], 3))//[3, 3, 2, 5]
print(s.maxSlidingWindow([1], 1)) // [1]
print(s.maxSlidingWindow([1, -1], 1)) // [1, -1]
print(s.maxSlidingWindow([9, 11], 2)) // [11]
print(s.maxSlidingWindow([4, 2], 2)) // [4]
