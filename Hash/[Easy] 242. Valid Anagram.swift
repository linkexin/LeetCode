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
