// 方法 1：自己 AC 的解法，对应官方的第二种解法，但是不知道为啥时间消耗比较多
class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard let first = strs.first, first.count > 0 else {
            return ""
        }
        guard strs.count > 1 else {
            return first
        }
        // 以第一个字符串为模板，一位一位比较，看后续字符串的第 i 为和第一个字符串的第 i 位是否一样
        for i in 0 ... first.count - 1 {
            for j in 1 ... strs.count - 1 {
                if strs[j].count < i {
                    // 如果第 j 位的字符串已经结束了，直接输出第 j 位字符串
                    return strs[j]
                }
                if strs[j][i] != first[i] {
                    // 一旦遇到一个不相等的，就能确定最大前缀了
                    return first[0..<i]
                }
            }
        }
        
        return first
    }
}

extension String {
    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

// 方法 2：用时少了很多，官方解法的第一种
// 思路是 先找到 s0,s1 的最大公共前缀 prefix，再找 s2 和 prefix 的最大公共前缀，并在过程中更新 prefix，这样一直遍历所有字符串
class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard let first = strs.first, first.count > 0 else {
            return ""
        }
        guard strs.count > 1 else {
            return first
        }
        var prefix = strs[0]
        for i in 1 ... strs.count - 1 {
            while strs[i].hasPrefix(prefix) == false {
                prefix.removeLast()
                if prefix.count == 0 {
                    break
                }
            }
        }
        return prefix
    }
}

// 方法 3：分治，对应官方题解的第三种方法，求解 s[0...l] 可以通过求 s[0...l/2] 和 s[l/2...l] 的公共前缀，原问题分解成子问题，再根据子问题的结果求原问题的结果
// 实现上用了递归，实现起来很简洁，时间复杂度和方法2 差不多
class Solution {
    func commonPrefix(_ strs: [String]) -> String {
        if strs.count == 1 {
            return strs.first ?? ""
        }
        let preL = commonPrefix(Array(strs[0..<strs.count / 2]))
        let preR = commonPrefix(Array(strs[strs.count / 2...strs.count - 1]))
        return preL.commonPrefix(with: preR)
    }
     
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard let _ = strs.first else {
            return ""
        }
        return commonPrefix(strs)
    }
}
