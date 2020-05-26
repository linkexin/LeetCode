// 自己第一遍 A 的解，堆里维护两个数组，数组元素一一对应，nodes[i] 为数字，counts[i] 为这个数字出现的次数，每次交换元素，两个数组都得交换
// 维护的是一个大顶堆，最后取结果从堆顶取，但是耗时比较长
// 评论里有一个题解：https://leetcode.com/problems/top-k-frequent-elements/discuss/523147/Swift-Heap-Solution
// 思路是先用一个循环将每个元素出现的次数统计好，然后将 (元素，次数) 这个元祖作为堆的元素，并且维护一个小顶堆，每次堆中元素个数超过 k，就移除堆顶元素
// 刚开始没想通为什么能够把超过了 k 个的元素直接移除，主要就是因为先统计好了每个元素的个数了
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
    var nodes = [Element]()
    var counts = [Int]()
    let priorityFunction: (Int, Int) -> Bool
    
    init(_ priorityFunction: @escaping (Int, Int) -> Bool) {
        self.priorityFunction = priorityFunction
    }
    
    // 将下标为 index 的元素向上移动到合适位置，来恢复堆结构
    mutating func shiftUp(_ index: Int) {
        var childIndex = index
        var parentIndex = childIndex.parentIndex
        while childIndex > 0 && priorityFunction(counts[childIndex], counts[parentIndex]) {
            swap(childIndex, parentIndex)
            childIndex = parentIndex
            parentIndex = childIndex.parentIndex
        }
    }
    
    // 将堆顶元素向下移动到合适位置，来恢复堆结构
    mutating func shiftDown() {
        var parentIndex = 0
        while true {
            var maxIndex = parentIndex.leftChild
            if maxIndex >= nodes.count {
                break
            }
            let rightIndex = parentIndex.rightChild
            if rightIndex < nodes.count && !priorityFunction(counts[maxIndex], counts[rightIndex]) {
                maxIndex = rightIndex
            }
            if !priorityFunction(counts[parentIndex], counts[maxIndex]){
                swap(parentIndex, maxIndex)
                parentIndex = maxIndex
            } else {
                break
            }
        }
    }
    
    mutating func swap(_ index1: Int, _ index2: Int) {
        let node = nodes[index1]
        nodes[index1] = nodes[index2]
        nodes[index2] = node
        
        let count = counts[index1]
        counts[index1] = counts[index2]
        counts[index2] = count
    }
}

extension Heap where Element == Int {
    mutating func insert(_ e:Element) {
        // 如果数字已经存在，把对应的 count + 1
        if let index = nodes.firstIndex(of: e) {
            counts[index] += 1
            shiftUp(index)
        } else {
            // 如果数字不存在，append 到维护再整理一下堆
            nodes.append(e)
            counts.append(1)
            shiftUp(nodes.count - 1)
        }
    }
    mutating func dequeue() -> Int? {
        swap(0, nodes.count - 1)
        let n = nodes.last
        nodes.removeLast()
        counts.removeLast()
        shiftDown()
        return n
    }
    func node(_ index: Int) -> Int {
        return nodes[index]
    }
}

class Solution {
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var heap = Heap<Int> { (n1, n2) -> Bool in
            return n1 > n2
        }
        for i in 0 ..< nums.count {
            heap.insert(nums[i])
        }
        var result = [Int]()
        for _ in 0 ..< k {
            result.append(heap.dequeue() ?? 0)
        }
        return result
    }
}
