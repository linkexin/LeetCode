// 队列先进先出，我的实现和官方题解的方式有点不一样，我是数组下标大的那一边为队列头，所以从是数组的头部插入，尾部弹出
// 要用队列的先进先出来实现栈的先进后出

// faster than 62.86%，less than 100.00%，用两个队列实现栈
class MyStack {
    // 使用两个队列相互倒腾的解法
    var inputQueue = [Int]()
    var outputQueue = [Int]()
    
    init() {}
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        // 往头部插入
        inputQueue.insert(x, at: 0)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        while inputQueue.count > 1 {
            outputQueue.insert(inputQueue.removeLast(), at: 0)
        }
        let result = inputQueue.last ?? 0
        inputQueue = outputQueue
        outputQueue = [Int]()
        return result
    }
    
    /** Get the front element. */
    func top() -> Int {
        var result = 0
        while !inputQueue.isEmpty {
            if inputQueue.count == 1 {
                result = inputQueue.last ?? 0
            }
            outputQueue.insert(inputQueue.removeLast(), at: 0)
        }
        inputQueue = outputQueue
        outputQueue = [Int]()
        return result
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return inputQueue.isEmpty && outputQueue.isEmpty
    }
}

class MyStack {
    // 只用一个队列
    var queue = [Int]()
    init() {}
    
    // 插入的时候，将所有先进的元素，一个一个先弹出，再按顺序插入到队列头，一顿操作以后，新插入的元素就在队列的最头部，pop 或者 top 的时候直接取队列头元素就可以
    // 参考官方题解的方法三
    func push(_ x: Int) {
        var size = queue.count
        queue.insert(x, at: 0)
        while size > 0 {
            queue.insert(queue.removeLast(), at: 0)
            size -= 1
        }
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        return queue.removeLast()
    }
    
    /** Get the front element. */
    func top() -> Int {
        return queue.last ?? 0
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return queue.isEmpty
    }
}



let obj = MyStack()
obj.push(1)
obj.push(2)
obj.top()
obj.pop()
obj.empty()


