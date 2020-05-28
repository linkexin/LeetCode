// 借着这题把几种排序算法顺了一遍

class Solution {
    func sortColors(_ nums: inout [Int]) {
        insertionSort(&nums)
    }
    
    func bubbleSort(_ nums: inout [Int]) {
        for i in 0 ..< nums.count {
            for j in 0 ..< nums.count - i - 1 {
                if nums[j] > nums[j + 1] {
                    let temp = nums[j]
                    nums[j] = nums[j + 1]
                    nums[j + 1] = temp
                }
            }
        }
    }
    
    func selectionSort(_ nums: inout [Int]) {
        for i in 0 ..< nums.count {
            var min = nums[i], index = i
            for j in i + 1 ..< nums.count {
                if nums[j] < min {
                    min = nums[j]
                    index = j
                }
            }
            let temp = nums[index]
            nums[index] = nums[i]
            nums[i] = temp
        }
    }
    
    func insertionSort(_ nums: inout [Int]) {
        for i in 1 ..< nums.count {
            var index = i
            for j in 0 ..< i {
                if nums[j] > nums[i] {
                    index = j // 找到第一个比 nums[i] 大的数
                    break
                }
            }
            let temp = nums[i]
            nums.remove(at: i)
            nums.insert(temp, at: index)
        }
    }
}

// https://juejin.im/post/5c276c145188256e047dbf12
func shellSort(_ nums: inout [Int]) {
    var gap = nums.count / 2
    while gap > 0 {
        for start in 0 ..< gap {
            for i in stride(from: start + gap, to: nums.count, by: gap) {
                // 这 for 循环是为了找到 nums[i] 应该在的位置
                // 从 i 位置往前找，只要前面位置的比 nums[i] 小，就交换位置
                let currentValue = nums[i]
                var pos = i
                while pos >= gap && nums[pos - gap] > currentValue {
                    nums[pos] = nums[pos - gap]
                    pos -= gap
                }
                nums[pos] = currentValue
            }
        }
        gap /= 2
    }
}

let s = Solution()
var arr = [2,0,2,1,1,0]
s.sortColors(&arr)
print(arr)
