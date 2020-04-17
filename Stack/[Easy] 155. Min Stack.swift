import UIKit

struct element {
    var value: Int
    var min: Int = Int.min
}

class MinStack {
    var stack = [element]()
    /** initialize your data structure here. */
    init() {
        
    }
    
    func push(_ x: Int) {
        if stack.count == 0 {
            stack.append(element(value: x, min: x))
        } else {
            let last = stack.last
            let curr_min = min(v1: last!.min, v2: x)
            stack.append(element(value: x, min: curr_min))
        }
    }
    
    func pop() {
        if stack.count > 0 {
            stack.removeLast()
        }
    }
    
    func top() -> Int {
        guard let l = stack.last else {
            return Int()
        }
        return l.value
    }
    
    func getMin() -> Int {
        guard let l = stack.last else {
            return Int()
        }
        return l.min
    }
    
    func min(v1: Int, v2: Int) -> Int {
        if v1 < v2 {
            return v1
        }
        return v2
    }
}

let obj = MinStack()
obj.top()
obj.pop()
obj.getMin()
obj.push(1)
obj.push(-123)
obj.push(-987)
obj.push(-2)
obj.getMin()
obj.pop()
obj.top()
obj.pop()
obj.top()
obj.getMin()
obj.pop()
obj.getMin()
