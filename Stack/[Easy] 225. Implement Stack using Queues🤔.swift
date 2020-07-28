// faster than 62.86%，less than 100.00%，用两个队列实现栈
class MyStack {
    var inputQueue = [Int]()
    var outputQueue = [Int]()
    
    init() {
        
    }
    
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


let obj = MyStack()
obj.push(1)
obj.push(2)
obj.top()
obj.pop()
obj.empty()


