// 题不难，就是有点繁琐 + 一些特殊 case
class Solution {
    func myAtoi(_ str: String) -> Int {
        var s = str
        while s.first == " " {
            s.removeFirst()
        }
        guard let fistAsc = s.first?.asciiValue else {
            return 0
        }
        if Int(fistAsc) != 43 && Int(fistAsc) != 45 && (Int(fistAsc) < 48 || Int(fistAsc) > 59) {
            return 0
        }
        var result = 0, flag = 1
        if s.first == "-" || s.first == "+" {
            if s.first == "-" {
                flag = -1
            }
            s.removeFirst()
        }
        for c in s {
            guard let asc = c.asciiValue, Int(asc) >= 48 && Int(asc) <= 59 else {
                break
            }
            result = result * 10 + Int(asc) - 48
            if result * flag > 1<<31 - 1 {
               return 1<<31 - 1
            }
            if result * flag < -1<<31 {
                return -1<<31
            }
        }
        return result * flag
    }
}
let s = Solution()
print(s.myAtoi("   912834+72332"))
print(s.myAtoi("   -91283472332"))
print(s.myAtoi("   +91283428734687272332"))
print(s.myAtoi("4193 with words"))
print(s.myAtoi("words and 987"))
print(s.myAtoi(""))
print(s.myAtoi("     "))
print(s.myAtoi("-42"))
print(s.myAtoi("-+1")) // 第一次 WA 在这个 case 上了
print("done")
