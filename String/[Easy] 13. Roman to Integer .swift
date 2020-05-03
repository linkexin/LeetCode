// 自己的解法：每次针对两位做特殊的判断
extension Character {
    static func + (left: Character, right: Character) -> String {
        return "\(left)\(right)"
    }
}
class Solution {
    func romanToInt(_ s: String) -> Int {
        let romans: [Character] = Array(s)
        var result = 0, i = 0
        let num: [Character: Int] = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000]
        let special: [String: Int] = ["IV": 4, "IX": 9, "XL": 40, "XC": 90, "CD": 400, "CM": 900]
        while i < s.count {
            if i < s.count - 1 {
                // 针对两位特殊判断
                let both = romans[i] + romans[i + 1]
                if special.keys.contains(both) {
                    result += special[both] ?? 0
                    i += 2
                    continue
                }
            }
            result += num[romans[i]] ?? 0
            i += 1
        }
        return result
    }
}

// 参考了别人的解法
class Solution {
    func romanLetterToInt(_ ch: Character) -> Int {
        switch (ch) {
            case "I":
                return 1
            case "V":
                return 5
            case "X":
                return 10
            case "L":
                return 50
            case "C":
                return 100
            case "D":
                return 500
            case "M":
                return 1000
            default:
                return 0
        }
    }
        
    func romanToInt(_ s: String) -> Int {
        let romans: [Character] = Array(s)
        guard romans.count > 0 else {
            return 0
        }
        var result = 0
        for i in 0 ... s.count - 1 {
            if i < s.count - 1 && romanLetterToInt(romans[i]) < romanLetterToInt(romans[i + 1]) {
                // 如果当前位数字比后一位数字小，减去当前位数字
                result -= romanLetterToInt(romans[i])
            } else {
                result += romanLetterToInt(romans[i])
            }
        }
        return result
    }
}

