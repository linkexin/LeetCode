// 第一次 A 超时，因为在找重复数的时候是从当前数字 + 1 开始往后遍历，看哪个数组没有出现过就用哪个数字，里面就存在比较多的重复计算
// 然后优化了一下 AC 了，空间复杂度 beat 100%，但是时间复杂度比较差，原因是排序 + 选取下一个目标数的时候还是有可能存在重复计算的过程
class Solution {
    func minIncrementForUnique(_ A: [Int]) -> Int {
        guard A.isEmpty == false else {
            return 0
        }
        // 先排序
        let A = A.sorted()
        // 记录已经存在的数组
        var existNums: Set<Int> = Set()
        var times = 0, targetNum = 1
        for i in 0 ..< A.count {
            // 如果 A[i] 已经出现过
            if existNums.contains(A[i]) {
                // 目标数字如果比 A[i] 小，那就从 A[i] + 1 开始递增判断
                // 目标数字如果比 A[i] 大，那就从 targetNum 数字开始递增判断
                var newNum = targetNum - A[i] > 0 ? targetNum : A[i] + 1
                while true {
                    if !existNums.contains(newNum) {
                        existNums.insert(newNum)
                        times += newNum - A[i]
                        // 更新下一个目标数字，也就是之后的数字有概率的不用再从 A[i] + 1 往后遍历了，优化了一些重复计算
                        targetNum = newNum + 1
                        existNums.insert(newNum)
                        break
                    }
                    newNum += 1
                }
            } else {
                // A[i] 还没出现过就加入集合中
                existNums.insert(A[i])
            }
        }
        return times
    }
}

// 参考了 https://leetcode-cn.com/problems/minimum-increment-to-make-array-unique/solution/ji-shu-onxian-xing-tan-ce-fa-onpai-xu-onlogn-yi-ya/
// 中的解法3，其实我自己的解法和这个有点相似，就是找 A[i] 的替换数字的时候，不从 A[i] + 1 开始往后尝试，减少反复探测，这种方式名曰「路径压缩」
// 这种解法用数组来帮助优化，具体是经过某条路径最终探测到一个空位置 x 后，将这条路径上的值都变成空位置所在的下标 x，那么假如下次探测的点又是这条路径上的点，则可以直接跳转到这次探测到的空位置 x，从 x 开始继续探测。
class Solution1 {
    func minIncrementForUnique(_ A: [Int]) -> Int {
        guard A.isEmpty == false else {
            return 0
        }
        // pos[n] 表示 下一个 n 出现的时候，从 pos[n] 开始尝试探测
        var pos = Array(repeatElement(-1, count: A.count * 2))
        var times = 0
        for i in 0 ..< A.count {
            let targetNum = findPos(A[i], &pos)
            times += targetNum - A[i]
        }
        return times
    }
    
    func findPos(_ num: Int, _ pos: inout [Int]) -> Int {
        if pos[num] == -1 {
            pos[num] = num
            return num
        }
        
        let i = findPos(pos[num] + 1, &pos)
        pos[num] = i
        return i
    }
}

// 官方题解的第一种：https://leetcode-cn.com/problems/minimum-increment-to-make-array-unique/solution/shi-shu-zu-wei-yi-de-zui-xiao-zeng-liang-by-leet-2/
// 依次遍历，找到没有出现过的数字，将直接重复的数字替换成当前这个没有出现的数字
// 有其中用到的一个很重要的优化是：遇到重复的数字，先减去重复数字，后面遇到没出现过的数字 A，直接加上 A
class Solution2 {
    func minIncrementForUnique(_ A: [Int]) -> Int {
        // nums[n] 表示数字 n 的个数
        var nums = Array(repeating: 0, count: A.count * 2)
        for n in A {
            nums[n] += 1
        }
        var taken = 0, times = 0
        
        for n in 0 ..< nums.count {
            if nums[n] == 0 && taken > 0 {
                taken -= 1
                times += n
            } else if nums[n] > 1 {
                taken += nums[n] - 1
                times -= (nums[n] - 1) * n
            }
        }
        return times
    }
}

//官方题解的f第二种：https://leetcode-cn.com/problems/minimum-increment-to-make-array-unique/solution/shi-shu-zu-wei-yi-de-zui-xiao-zeng-liang-by-leet-2/
// 其中有一个优化点，计算 4+5+6+7 可以不用 while 循环，4+5+6+7 = 3*4 +（1+2+3+4）= 3*4 + 4*5 / 2
class Solution3 {
    func minIncrementForUnique(_ A: [Int]) -> Int {
        guard A.count > 0 else {
            return 0
        }
        let A = A.sorted()
        var taken = 0, times = 0
        for i in 1 ..< A.count {
            if A[i] == A[i - 1] {
                taken += 1
                times -= A[i]
            } else if A[i] > A[i - 1] + 1 && taken > 0 {
                let give = min(A[i] - 1 - A[i - 1], taken)
                taken -= give
//                    while give > 0 {
//                        times += temp
//                        temp += 1
//                        give -= 1
//                    }
                // 用公式简化上面的 while
                times += give * A[i - 1] + ((give * (give + 1)) / 2)
            }
        }
//            var n = (A.last ?? -1) + 1
//            while taken > 0 {
//                times += n
//                n += 1
//                taken -= 1
//            }
        // 用公式简化上面的 while
        if taken > 0 {
            times += taken * A[A.count - 1] + (taken * (taken + 1)) / 2
        }
        return times
    }
}


let s = Solution3()
print(s.minIncrementForUnique([3,2,1,2,1,7])) //6
print(s.minIncrementForUnique([2,2,2,2,0])) //6
print(s.minIncrementForUnique([1,3,0,3,0])) //3
print(s.minIncrementForUnique([4,4,7,5,1,9,4,7,3,8])) //12
print(s.minIncrementForUnique([]))
