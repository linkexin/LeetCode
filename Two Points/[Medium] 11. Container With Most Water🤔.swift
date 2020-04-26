//// 这种方式和题解中的暴力求解一样，但是 swift 就会超时？
//class Solution {
//    func maxArea(_ height: [Int]) -> Int {
//        if height.count <= 1 {
//            return 0
//        }
//        var capacity = 0
//        for i in 0..<height.count - 1 {
//            for j in i + 1..<height.count - 1 {
//                let a = min(height[i], height[j]) * (j - i)
//                capacity = max(a, capacity)
//            }
//        }
//        return capacity
//    }
//}

// 这两个题解不错：
// https://leetcode-cn.com/problems/container-with-most-water/solution/sheng-zui-duo-shui-de-rong-qi-by-leetcode-solution/
// https://leetcode-cn.com/problems/container-with-most-water/solution/shi-pin-ti-jie-made-by-manim-by-sgreen-2/
class Solution {
    func maxArea(_ height: [Int]) -> Int {
        if height.count <= 1 {
            return 0
        }
        var capacity = 0
        var left = 0, right = height.count - 1
        while left != right {
            let s = min(height[left], height[right]) * (right - left)
            capacity = max(s, capacity)
//            print(s, capacity)
            if height[left] < height[right] {
                left += 1
            } else {
                right -= 1
            }
        }
        return capacity
    }
}

let s = Solution()
s.maxArea([2,3,4,5,18,17,6])
