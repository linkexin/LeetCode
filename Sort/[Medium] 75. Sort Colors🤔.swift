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

let s = Solution()
var arr = [2,0,2,1,1,0]
s.sortColors(&arr)
print(arr)
