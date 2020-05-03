class Solution {
    func asciiInt(_ c: Character) -> Int {
        return Int(c.asciiValue! - 48)
    }
    func charFromInt(_ i: Int) -> String {
        return String(UnicodeScalar(i + 48)!)
    }
    
    func addStrings(_ num1: String, _ num2: String) -> String {
        var result = ""
        let n1 = Array(num1), n2 = Array(num2)
        var i = n1.count - 1, j = n2.count - 1, flag = 0
        while i >= 0 || j >= 0 {
            var re = flag
            if i >= 0 {
                re += asciiInt(n1[i])
            }
            if j >= 0 {
                re += asciiInt(n2[j])
            }
            result = charFromInt(re % 10) + result
            flag = re / 10
            i -= 1
            j -= 1
        }
        if flag != 0 {
            result = String(flag) + result
        }
        return result
    }
}
