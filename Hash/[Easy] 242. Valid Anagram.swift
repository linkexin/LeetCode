class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else {
            return false
        }
        var s1Map = [Character: Int]()
        for c in s {
            s1Map[c, default: 0] += 1
        }
        var s2Map = [Character: Int]()
        for c in t {
            s2Map[c, default: 0] += 1
        }
        
        return s1Map == s2Map
    }
}

// 将 string 排序分别得到对应字母序的数组，然后直接比较两个数组
// 这种方式写起来简单，但是耗时比较长
class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        let s = s.sorted()
        let t = t.sorted()
        return s == t
    }
}
