// 64ms
// 最容易想到的排序后输出，可能是测试用例的关系，这种方法反而挺快的
class Solution {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        let nums = nums.sorted()
        return nums[nums.count - k]
    }
}

// ------------------------------------------------------
// 80ms
// 堆 的实现方式，堆的具体实现参考：https://swift.gg/2019/05/06/implementing-a-heap-based-priority-queue-using-swift/
// 维护一个小顶堆，保证堆的容量为输入的 k，堆中的元素就是前 k 个大的数，前 k 个大的数中取最小的，就是第 k 大的数
extension Int {
    var parentIndex: Int {
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
    var elements = [Element]()
    let priorityFunction: (Element, Element) -> Bool
    
    init(_ priorityFunction: @escaping (Element, Element) -> Bool) {
        self.priorityFunction = priorityFunction
    }
    
    func count() -> Int {
        return elements.count
    }
    
    func top() -> Element? {
        return elements.first
    }
    
    mutating func insert(_ ele: Element) {
        elements.append(ele)
        shiftUp(elements.count - 1)
    }
    
    // 将指定下标的元素向上移动到队头来恢复堆
    mutating func shiftUp(_ index: Int) {
        var childIndex = index
        let child = elements[index]
        var parentIndex = index.parentIndex
        
        while childIndex > 0 && priorityFunction(child, elements[parentIndex]) {
            swap(childIndex, parentIndex)
            childIndex = parentIndex
            parentIndex = childIndex.parentIndex
        }
    }
    
    // 将队头向下移动来恢复堆
    mutating func shiftDown() {
        var index = 0
        
        while true {
            var minChild = index.leftChild
            if minChild >= elements.count {
                break
            }
            
            let rightChild = index.rightChild
            if rightChild < elements.count && !priorityFunction(elements[minChild], elements[rightChild]) {
                minChild = rightChild
            }
            
            if priorityFunction(elements[index], elements[minChild]) == false {
                swap(index, minChild)
                index = minChild
            } else {
                break
            }
        }
    }
    
    mutating func dequeue() {
        guard elements.count > 0 else {
            return
        }
        swap(0, elements.count - 1)
        elements.removeLast()
        shiftDown()
    }
    
    mutating func swap(_ index1: Int, _ index2: Int) {
        let temp = elements[index1]
        elements[index1] = elements[index2]
        elements[index2] = temp
    }
}

class Solution1 {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var heap = Heap<Int>( < )
        for i in 0 ..< nums.count {
            heap.insert(nums[i])
            // 超过 k 个就把堆顶元素移除
            if heap.count() > k {
                heap.dequeue()
            }
        }
        return heap.top() ?? 0
    }
}

// ------------------------------------------------------
// 48ms
// 快速选择，https://zh.wikipedia.org/wiki/%E5%BF%AB%E9%80%9F%E9%80%89%E6%8B%A9 维基百科的伪代码清清楚楚
class Solution2 {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums
        let target = nums.count - k // 第 k 大的数就是第 nums.count - k 小的数
        var begin = 0, end = nums.count - 1
        var index = partition(begin, end, &nums)
        while index != target {
            if index < target {
                begin = index + 1
            } else {
                end = index - 1
            }
            index = partition(begin, end, &nums)
        }
        return nums[index]
    }
    
    // 按照给定区间分区
    func partition(_ begin: Int, _ end: Int, _ nums: inout [Int]) -> Int {
        // 随机生成一个下标作为基准元素
        let pivotIndex = Int.random(in: begin ... end)
        swap(pivotIndex, end, &nums)
        
        var storeIndex = begin
        for i in begin ..< end {
            // 所有小于等于基准元素的都往前靠
            if nums[i] <= nums[end] {
                swap(storeIndex, i, &nums)
                storeIndex += 1
            }
        }
        // 最后将基准元素放在所有小于等于它的元素的后面
        swap(storeIndex, end, &nums)
        return storeIndex
    }
    
    func swap(_ index1: Int, _ index2: Int, _ nums: inout [Int]) {
        let temp = nums[index1]
        nums[index1] = nums[index2]
        nums[index2] = temp
    }
}
