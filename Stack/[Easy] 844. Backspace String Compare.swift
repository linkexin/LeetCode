// 常规栈解法
class Solution {
    func backspaceCompare(_ S: String, _ T: String) -> Bool {
        return finalString(S) == finalString(T)
    }
    
    func finalString(_ s: String) -> String {
        var stack = [Character]()
        for c in s {
            if c != "#" {
                stack.append(c)
            } else {
                _ = stack.popLast()
            }
        }
        return String(stack)
    }
}
