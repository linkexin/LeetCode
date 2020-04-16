import UIKit
class MyStack {
    
    init() {
        
    }
    var stack = [Int]()
    /** Push element x onto stack. */
    func push(_ x: Int) {
        stack.append(x)
    }
    
    /** Removes the element on top of the stack and returns that element. */
    func pop() -> Int {
        return stack.removeLast()
    }
    
    /** Get the top element. */
    func top() -> Int {
        return stack.last!
    }
    
    /** Returns whether the stack is empty. */
    func empty() -> Bool {
        return stack.isEmpty
    }
}


let obj = MyStack()
obj.push(1)
obj.push(2)
obj.top()
obj.pop()
obj.empty()


