// 这个解法的关键在于碰到重复字符(下标在 index)，下一次就从 index + 1 开始遍历
// 理解为什么可以从 index + 1 开始很重要
class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        var substring = [Character]()
        var length = 0
        
        for c in s {
            if substring.contains(c), let index = substring.firstIndex(of: c) {
                length = max(substring.count, length)
                substring.removeSubrange(0...index)
            }
            substring.append(c)
        }
        return max(substring.count, length)
    }
}

// 最开始使用双指针的方式，但是超时了
// 超时的点应该在于：每次 j 都从 i + 1 开始，重复了很多不必要的判断
class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.count == 0 {
            return 0
        }
        if s.count == 1 {
            return 1
        }
        var max = 1
        if s.count <= 2 {
            
        }
        for i in 0...s.count - 2 {
            if max > s.count - i - 1 {
                break
            }
            var lineMax = 1
            for j in i + 1...s.count - 1 {
                let letter = s[j]
                let preString = s[i...j - 1]
                if preString.contains(letter) {
                    break
                } else {
                    lineMax += 1
                }
            }
            if max < lineMax {
                max = lineMax
            }
        }
        return max
    }
}

extension String {
    subscript(_ i: Int) -> String {
        let idx1 = index(startIndex, offsetBy: i)
        let idx2 = index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
    subscript (r: CountableClosedRange<Int>) -> String {
        let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return String(self[startIndex...endIndex])
    }
}
