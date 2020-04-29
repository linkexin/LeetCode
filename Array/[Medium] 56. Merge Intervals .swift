// 排序 + 单指针
class Solution {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        // 将左右边界放入分别放入两个数组中
        var left = [Int](), right = [Int]()
        for pair in intervals {
            if pair.count < 2 {
                return []
            }
            left.append(pair[0])
            right.append(pair[1])
        }
        // 排序
        left = left.sorted()
        right = right.sorted()
        
        var p = 0
        var merge = [[Int]]()
        var pair = [Int]()
        // 单指针遍历 left right 两个数组
        while p < intervals.count {
            if pair.isEmpty {
                pair.append(left[p])
            }
            // 如果当前的左边界大于上一个右边界，说明区间不相邻，不重叠，可以直接输出
            if p > 0 && left[p] > right[p - 1] {
                pair.append(right[p - 1])
                merge.append(pair)
                pair = [left[p]]
            }
            if p == intervals.count - 1 {
                pair.append(right[p])
                merge.append(pair)
            }
            // 如果当前的左边界小于等于上一个右边界，说明区间响铃或重叠，指针后移，进行新的判断
            p += 1
        }
        return merge
    }
}

let s = Solution()
s.merge([[1,3],[2,6],[8,10],[15,18]])
// 总共有以下四种情况
s.merge([[1,3],[4,5],[6,7],[-1,0]]) // 不相交
s.merge([[0,2],[3,6],[4,7]]) // 重叠
s.merge([[0,2],[4,6],[5,7],[2,4]]) // 相邻
s.merge([[3,5],[4,6],[0,2],[1,8]]) // 包含
// 一些边界 case
s.merge([[]])
s.merge([[1,2],[3]])
s.merge([[1,2]])
