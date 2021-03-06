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
// ---------------
// 归并排序 https://www.jianshu.com/p/7829fce77153
// 原始数组是否排序好与速度无关，因为无论是否排序，归类排序都需要先将数组拆分，然后再合并。因此，归类排序算法的时间复杂度永远为O(nlogn)
// 对于归类排序算法来说，它的缺点就是在排序过程中，需要创建一个大小与被排序数组相同的工作数组，这个与就地排序类型的算法不一样

// 因为不是原地排序，所以不需要传 start end，直接将子数组传进来
func mergeSort(_ nums: [Int]) -> [Int] {
    guard nums.count > 1 else {
        return nums
    }
    
    let middle = nums.count / 2
    let leftArr = mergeSort(Array(nums[0 ..< middle])) // 注意这里一定是左闭右开，不然数组中的个数永远不会小于2，死循环
    let rightArr = mergeSort(Array(nums[middle ..< nums.count]))
    return merge(leftArr, rightArr)
}

// 合并两个有序数组，其实就是双指针操作
func merge(_ leftArr: [Int], _ rightArr: [Int]) -> [Int] {
    var orderedArr = [Int]()
    var leftI = 0, rightI = 0
    while leftI < leftArr.count && rightI < rightArr.count {
        if leftArr[leftI] < rightArr[rightI] {
            orderedArr.append(leftArr[leftI])
            leftI += 1
        } else if leftArr[leftI] > rightArr[rightI] {
            orderedArr.append(rightArr[rightI])
            rightI += 1
        } else {
            orderedArr.append(leftArr[leftI])
            leftI += 1
            orderedArr.append(rightArr[rightI])
            rightI += 1
        }
    }
    
    while leftI < leftArr.count {
        orderedArr.append(leftArr[leftI])
        leftI += 1
    }
    while rightI < rightArr.count {
        orderedArr.append(rightArr[rightI])
        rightI += 1
    }
    return orderedArr
}

// ---------------
// https://zhuanlan.zhihu.com/p/40179798
// https://zh.wikipedia.org/wiki/%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F 维基百科的伪代码写的很直白
func quickSort(_ sta: Int, _ end: Int, _ nums: inout [Int]) {
    if sta >= end {
        return
    }
    let pivot = partition(sta, end, &nums)
    // 因为 pivot 已经在最终正确的位置了，所以接下来的排序就不需要再包含 pivot
    quickSort(sta, pivot - 1, &nums) // 注意这里的 pivot - 1
    quickSort(pivot + 1, end, &nums) // 注意这里的 pivot + 1
}

func partition(_ sta: Int, _ end: Int, _ nums: inout [Int]) -> Int {
    let pivot = (sta + end) / 2
    let pivotValue = nums[pivot]
    swap(pivot, end, &nums)
    
    var index = sta // 这里注意，index 的初始值是左边界
    for i in sta ..< end {
        if nums[i] <= pivotValue {
            swap(index, i, &nums)
            index += 1
        }
    }
    swap(index, end, &nums)
    return index
}

func swap(_ index1: Int, _ index2: Int, _ nums: inout [Int]) {
    let temp = nums[index1]
    nums[index1] = nums[index2]
    nums[index2] = temp
}

// --------------
extension Int {
    var parent: Int {
        return (self - 1) / 2
    }
    var leftChild: Int {
        return self * 2 + 1
    }
    var rightChild: Int {
        return self * 2 + 2
    }
}

struct Heap<Element> {
    var nodes = [Element]()
    var priority: (Element, Element) -> Bool
    
    init(_ priority: @escaping (Element, Element) -> Bool) {
        self.priority = priority
    }
    
    mutating func insert(ele: Element) {
        // 每次插入将元素放到最后，然后将元素向上移动，来恢复堆结构
        nodes.append(ele)
        shiftUp(nodes.count - 1)
    }
     
    // 把元素向下移动，以恢复堆结构
    // 这里需要传入范围，针对范围内的数进行整理
    mutating func shiftDown(_ sta: Int, _ end: Int) {
        var parent = sta
        while parent <= end {
            var maxChild = parent.leftChild
            if maxChild > end {
                break
            }
            let rightChild = parent.rightChild
            if rightChild <= end && priority(nodes[maxChild], nodes[rightChild]) {
                maxChild = rightChild
            }
            if priority(nodes[parent], nodes[maxChild]) {
                swap(parent, maxChild)
            } else {
                break
            }
            parent = maxChild
        }
    }
    
    // 把元素向上移动，以恢复堆结构
    mutating func shiftUp(_ index: Int) {
        var child = index
        var parent = index.parent
        while parent >= 0 {
            if priority(nodes[parent], nodes[child]) {
                swap(child, parent)
                child = parent
                parent = child.parent
            } else {
                break
            }
        }
    }
    
    mutating func swap(_ index1: Int, _ index2: Int) {
        let temp = nodes[index1]
        nodes[index1] = nodes[index2]
        nodes[index2] = temp
    }
}

extension Heap {
    mutating func sort() {
        for i in stride(from: nodes.count - 1, to: 0, by: -1) {
            swap(0, i)
            shiftDown(0, i - 1)
        }
    }
}

func sortColors(_ nums: inout [Int]) {
    var heap = Heap<Int>.init({ (n1, n2) -> Bool in
        return n1 < n2
    })
    for n in nums {
        heap.insert(ele: n)
    }
    heap.sort()
    nums = heap.nodes
}


let s = Solution()
var arr = [2,0,2,1,1,0]
s.sortColors(&arr)
print(arr)
