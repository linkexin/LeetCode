// 自己 AC 的解法，栈 + 区间合并，先利用栈将所有匹配的括号的 [开始，结束] 区间全部记下来，然后再把这些区间进行区间合并，找出最长的区间
// 虽然是 A 了，但是效率不高，官方题解并没有我这种思路的😂
class Solution {
    func longestValidParentheses(_ s: String) -> Int {
        var count = 0
        var stack = [(Int, Character)](), each = [(Int, Int)]()
        let s = Array(s)
        for (i, c) in s.enumerated() {
            if c == "(" {
                stack.append((i, c))
            } else if c == ")" {
                guard let top = stack.last else {
                    continue
                }
                // 如果栈顶是 “(”，那么可以配对，将区间记录下来
                if top.1 == "(" {
                    stack.removeLast()
                    each.append((top.0, i))
                } else {
                    // 如果栈顶不是 “(”，无法配对，直接入栈
                    stack.append((i, c))
                }
            }
        }
        
        // 将所有区间按照区间开始的位置，从小到大排序
        each = each.sorted(by: { (n1, n2) -> Bool in
            n1 < n2
        })
        guard let first = each.first else {
            return 0
        }
        var sta = first.0, end = first.1
        for i in 1 ..< each.count {
            if each[i].0 - 1 == end {
                // 相邻，更新区间大小
                end = each[i].1
            } else if sta < each[i].0 && end > each[i].1 {
                // 包含 do nothing
            } else {
                // 不相交，更新最大值
                count = max(count, end - sta + 1)
                sta = each[i].0
                end = each[i].1
            }
        }
        count = max(count, end - sta + 1)
        return count
    }
}

// 优化了一下上面的解法，主要是将区间合并的过程放到了 for 循环中一起进行，只不过优化效果一般
class Solution1 {
    // 尝试将新区间和现有的区间合并
    func mergeIfNeeded(_ each: inout [(Int, Int)], new: (Int, Int)) {
        guard var last = each.last else {
            each.append(new)
            return
        }
        if last.1 + 1 == new.0 {
            // 相邻
            last.1 = new.1
            each.removeLast()
            // 递归下去看看是否还能再合并
            mergeIfNeeded(&each, new: last)
        } else if last.0 > new.0 && last.1 < new.1 {
            // 包含
            each.removeLast()
            // 递归下去看看是否还能再合并
            mergeIfNeeded(&each, new: new)
        } else {
            // 不相交，直接 append
            each.append(new)
        }
    }
    
    func longestValidParentheses(_ s: String) -> Int {
        var count = 0
        var stack = [(Int, Character)](), each = [(Int, Int)]()
        let s = Array(s)
        for (i, c) in s.enumerated() {
            if c == "(" {
                stack.append((i, c))
            } else if c == ")" {
                guard let top = stack.last else {
                    continue
                }
                if top.1 == "(" {
                    stack.removeLast()
                    mergeIfNeeded(&each, new: (top.0, i))
                    // 有新区间产生，尝试和之间的区间合并
                    count = max(count, each.last!.1 - each.last!.0 + 1)
                } else {
                    stack.append((i, c))
                }
            }
        }
        return count
    }
}


let s = Solution()
print(s.longestValidParentheses("(()())")) // 6
print(s.longestValidParentheses("()(()())")) // 8
print(s.longestValidParentheses("(()(()((((")) // 2
print(s.longestValidParentheses("(()(()()(((")) // 4
print(s.longestValidParentheses("(()")) // 2
print(s.longestValidParentheses("()(())")) // 6
