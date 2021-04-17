// kmp
class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        return kmp(s: Array(haystack), p: Array(needle))
    }
    
    func kmp(s: [Character], p: [Character]) -> Int {
        let m = s.count, n = p.count
        if p.count == 0 { return 0 }
        
        var i = 0, j = 0
        let next = getNext(p)
        
        while i < m && j < n {
            if j == -1 || s[i] == p[j] {
                i += 1
                j += 1
            } else {
                j = next[j]
            }
        }
        
        return (j == n) ? i - j : -1
    }
    
    /// 求解 next 数组
    func getNext(_ p: [Character]) -> [Int] {
        let n = p.count
        var k = -1, j = 0
        var next = Array<Int>(repeating: 0, count: n)
        next[0] = -1
        
        while j < n - 1 {
            if k == -1 || p[k] == p[j] {
                j += 1
                k += 1
                next[j] = (p[j] == p[k] ? next[k] : k)
            } else {
                k = next[k]
            }
        }
        
        return next
    }
}
