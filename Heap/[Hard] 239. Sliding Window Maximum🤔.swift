// 另一种实现在 Slide Window 中找
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

struct Heap<ElementType> {
    var elements = [ElementType]()
    var priority: (ElementType, ElementType) -> Bool
    init(_ priority: @escaping (ElementType, ElementType) -> Bool) {
        self.priority = priority
    }
    
    func count() -> Int {
        return elements.count
    }
    
    func first() -> ElementType? {
        return elements.first
    }
    
    mutating func push(_ ele: ElementType) -> ElementType? {
        elements.append(ele)
        shiftUp(elements.count - 1)
        return elements.first
    }
    
    mutating func remove(_ index: Int) -> ElementType? {
        guard !elements.isEmpty && index < elements.count else {
            return nil
        }
        let size = elements.count - 1
        if index != size {
            swap(index, size)
            shiftDown(from: index, until: size)
            shiftUp(index)
        }
        return elements.removeLast()
    }
    
    // 向上移动，来恢复堆的顺序
    mutating func shiftUp(_ index: Int) {
        var childIndex = index
        let child = elements[childIndex]
        var parentIndex = childIndex.parent
    
        while childIndex > 0 && priority(elements[childIndex], elements[parentIndex]) {
            swap(parentIndex, childIndex)
            childIndex = parentIndex
            parentIndex = childIndex.parent
        }
        elements[childIndex] = child
    }
    
    // 将指定元素向下移动，来恢复堆的顺序
    internal mutating func shiftDown(from index: Int, until endIndex: Int) {
        let leftChildIndex = index.leftChild
        let rightChildIndex = leftChildIndex + 1
        
        var first = index
        if leftChildIndex < endIndex && priority(elements[leftChildIndex], elements[first]) {
            first = leftChildIndex
        }
        if rightChildIndex < endIndex && priority(elements[rightChildIndex], elements[first]) {
            first = rightChildIndex
        }
        if first == index { return }
        
        swap(index, first)
        shiftDown(from: first, until: endIndex)
    }
    
    internal mutating func shiftDown(_ index: Int) {
        shiftDown(from: index, until: elements.count)
    }
    
    mutating func swap(_ index1: Int, _ index2: Int) {
        let temp = elements[index1]
        elements[index1] = elements[index2]
        elements[index2] = temp
    }
}

extension Heap where ElementType == Int {
    mutating func replace(_ oldEle: ElementType, _ ele: ElementType) -> ElementType? {
        let index = findElement(oldEle)
        guard index >= 0 else {
            return nil
        }
        _ = remove(index)
        _ = push(ele)
        return elements.first
    }
    
    func findElement(_ ele: ElementType) -> Int {
        return elements.firstIndex(of: ele) ?? -1
    }
}

// 堆的解法，维护一个大小为 k 的大顶堆，在 WA 了两次以后，超时了 T T，BTW，说明堆的思路是没错的
class Solution {
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        guard nums.count > 0 else {
            return []
        }
        var result = [Int]()
        var heap = Heap<Int>( > ) // 大顶堆
        
        for i in 0 ..< nums.count {
            if heap.count() < k {
                _ = heap.push(nums[i])
                if heap.count() == k {
                    result.append(heap.first() ?? 0)
                }
            } else {
                result.append(heap.replace(nums[i - k], nums[i]) ?? 0)
            }
        }
        
        return result
        
    }
}
