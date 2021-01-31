// 用两个栈实现队列
class MyQueue {
    // 定义一个输入栈，一个输出栈，push 对输入栈操作，pop 和 peek 对输出栈操作
    var inputStack = [Int]()
    var outputStack = [Int]()
    
    init() {
        
    }
    
    /** Push element x to the back of queue. */
    func push(_ x: Int) {
        inputStack.append(x)
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        if outputStack.isEmpty {
            // 当输出栈为空时，需要将输入栈的元素倒腾过来
            transferStacks()
        }
        return outputStack.removeLast()
    }
    
    /** Get the front element. */
    func peek() -> Int {
        if outputStack.isEmpty {
            // 当输出栈为空时，需要将输入栈的元素倒腾过来
            transferStacks()
        }
        return outputStack.last ?? 0
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return inputStack.isEmpty && outputStack.isEmpty
    }
    
    func transferStacks() {
        while inputStack.isEmpty == false {
            // 这里是栈变成队列的关键，inputStack 先输出的部分，append 到 outputStack 后变成后输出
            // 这样 FILO 就变成了 FIFO
            outputStack.append(inputStack.removeLast())
        }
    }
}

let obj = MyQueue()
obj.push(1)
obj.push(2)
let ret_2: Int = obj.pop()
let ret_3: Int = obj.peek()
let ret_4: Bool = obj.empty()
print("\(ret_2), \(ret_3), \(ret_4)")


// 2021.01.30 版本
// 首先实现一个 pure stack，封装好 stack 特有的操作
class Stack {
    var arr = [Int]()
    func push(_ x: Int) {
        arr.append(x)
    }
    func pop() -> Int {
        return arr.removeLast()
    }
    func count() -> Int {
        return arr.count
    }
}

class MyQueue {
    var stack = Stack()
    
    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Push element x to the back of queue. */
    // 在 push 阶段就数据按照 queue 的规则排列好
    func push(_ x: Int) {
        let tempStack = Stack()
        for _ in 0 ..< stack.count() {
            tempStack.push(stack.pop())
        }
        stack.push(x)
        for _ in 0 ..< tempStack.count() {
            stack.push(tempStack.pop())
        }
    }
    
    /** Removes the element from in front of queue and returns that element. */
    func pop() -> Int {
        return stack.pop()
    }
    
    /** Get the front element. */
    func peek() -> Int {
        let peek = stack.pop()
        stack.push(peek)
        return peek
    }
    
    /** Returns whether the queue is empty. */
    func empty() -> Bool {
        return stack.count() == 0
    }
}
