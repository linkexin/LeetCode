// 这题本意应该是用处理数字的方式来做，我就直接转成数组来处理啦
class Solution {
    func isPalindrome(_ x: Int) -> Bool {
        let s = Array(String(x))
        var i = 0, j = s.count - 1
        while i <= j {
            if s[i] != s[j] {
                return false
            }
            i += 1
            j -= 1
        }
        return true
    }
}
