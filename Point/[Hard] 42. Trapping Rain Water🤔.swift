// 最初自己 AC 的代码，后面根据题解用其他方法 A，结果时间和空间还不如自己的这个版本，虽然代码量比较多一些
// 考虑可以装雨水的两种情况：
// 1. 右墙比左墙高，按顺序遍历的时候可以直接计算两墙之间的雨水量
// 2. 左墙比右墙高，需要一直遍历到底，找到右边的墙中最高的墙，作为右边界墙，来计算两墙之间的雨水量
// 为了计算方便，不反复遍历，用一个 struct 存储中间状态
class Solution {
    struct locationInfo {
        var calculatedMap = 0 // 当前位置及当前位置之前所有柱子的总和
        var index = 0 // 当前位置对应的下标
    }
    
    func trap(_ height: [Int]) -> Int {
        if height.count < 3 {
            return 0
        }
        var capacity = 0
        var left = 0, right = 1
        while left <= height.count - 3 {
            var stack = [locationInfo]()
            var maxIndex = -1, maxHeight = -1, top = height[left]
            while right < height.count {
                // 如果右墙比左墙高，说明两墙之间可以装雨水，直接计算
                if height[right] >= top {
                    let occupied = stack.last?.calculatedMap ?? 0
                    capacity += calculateCapacity(height1: top,
                                                  height2: height[right],
                                                  dis: right - left,
                                                  occupied: occupied)
                    // 下一次迭代，直接从右墙开始
                    left = right
                    right += 1
                    break
                } else {
                    // 如果右墙比左墙高，入栈，然后继续找后续可能出现的更高的墙
                    let calculatedMap = (stack.last?.calculatedMap ?? 0) + height[right]
                    let location = locationInfo(calculatedMap: calculatedMap, index: right)
                    stack.append(location)
                    // 在过程中记录下右边出现的最高的及其位置
                    if maxHeight < height[right] {
                        maxHeight = height[right]
                        maxIndex = stack.count - 1
                    }
                    // 一直遍历到最后还是没有比左墙高的墙出现，就选择右边的墙中最高的墙进行计算
                    if right == height.count - 1 && maxIndex >= 0 {
                        capacity += calculateCapacity(height1: top,
                                                      height2: height[stack[maxIndex].index],
                                                      dis: stack[maxIndex].index - left,
                                                      occupied: stack[maxIndex].calculatedMap - height[stack[maxIndex].index]) // 注意这里要减去右墙本身的高度
                        // 下一次迭代，从右墙开始
                        left = stack[maxIndex].index
                        right = left + 1
                        break
                    }
                    right += 1
                }
            }
        }
        return capacity
    }
    // 左墙高度、右墙高度、两墙之前的距离、两墙之间的墙的高度总和
    func calculateCapacity(height1: Int, height2: Int, dis: Int, occupied: Int) -> Int {
        if dis <= 1 {
            return 0
        }
        return min(height1, height2) * (dis - 1) - occupied
    }
}

// O(n²) 实际跑出来，时间消耗挺大的
// 对应 https://leetcode-cn.com/problems/trapping-rain-water/solution/xiang-xi-tong-su-de-si-lu-fen-xi-duo-jie-fa-by-w-8/ 中的解法二
// 思路是按列计算，找到当前列左边的最大值和右边的最大值，以这两个值为边界计算当前列上面可以存多少雨水
class Solution {
    func trap(_ height: [Int]) -> Int {
        if height.count < 3 {
            return 0
        }
        var capacity = 0
        for i in 1...height.count - 2 {
            var leftMax = -1
            for li in 0 ... i {
                leftMax = max(leftMax, height[li])
            }
            
            var rightMax = -1
            for lr in i + 1 ... height.count - 1 {
                rightMax = max(rightMax, height[lr])
            }
            
            let minl = min(leftMax, rightMax)
            if minl > height[i] {
                capacity += minl - height[i]
            }
        }
        
        return capacity
    }
}

// O(n), 在上一个解法的基础上，用动态规划的优化求解最小值最大值的过程
// 对应 https://leetcode-cn.com/problems/trapping-rain-water/solution/xiang-xi-tong-su-de-si-lu-fen-xi-duo-jie-fa-by-w-8/ 中的解法三
// 主要是利用 left[i] = max(left[i - 1], height[i])
class Solution {
    func trap(_ height: [Int]) -> Int {
        if height.count < 3 {
            return 0
        }
        var capacity = 0
        // leftMax[i] 表示 第 i 列 左边的最大值， rightMax[i] 表示 第 i 列 右边的最大值
        var leftMax = Array.init(repeating: 0, count: height.count)
        var rightMax = Array.init(repeating: 0, count: height.count)
        // 先用动态规划的思路计算出每个位置左边的最小值，最大值
        for i in 1...height.count - 1 {
            leftMax[i] = max(leftMax[i - 1], height[i - 1])
        }
        
        for j in (0...height.count - 2).reversed() {
            rightMax[j] = max(rightMax[j + 1], height[j + 1])
        }
        
        // 通过计算出来的最小值最大值求解
        for i in 1...height.count - 1 {
            let minl = min(leftMax[i], rightMax[i])
            if minl > height[i] {
                capacity += minl - height[i]
            }
        }
        
        return capacity
    }
}

// O(n)
// 对应题解：https://leetcode-cn.com/problems/trapping-rain-water/solution/trapping-rain-water-by-ikaruga/
// 单调栈，每次找到可以装水的最小「单位」，既然是最小，那就表示一定是 3 堵墙组成，且中间的墙小于两边的墙
class Solution {
    func trap(_ height: [Int]) -> Int {
        if height.count < 3 {
            return 0
        }
        var capacity = 0
        
        var stack = [Int]()
        for i in 0 ... height.count - 1 {
            while !stack.isEmpty && height[stack.last!] < height[i] {
                let cur = stack.last
                stack.removeLast()
                if stack.isEmpty {
                    break
                }
                let left = stack.last!, right = i
                // 需要减去 height[cur!]
                capacity += (min(height[left], height[right]) - height[cur!]) * (right - left - 1)
            }
            stack.append(i)
        }
        
        return capacity
    }
}

let s = Solution()
s.trap([2,1,0,1,3])
