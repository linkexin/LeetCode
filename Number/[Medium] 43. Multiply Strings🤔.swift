// runtime beats 83.85 %，memory beats 100%
class Solution {
    func multiply(_ num1: String, _ num2: String) -> String {
        if num1 == "0" || num2 == "0" {
            return "0"
        }
        // 先转换成数组，且将元素倒转
        let n1 = Array(num1.reversed()), n2 = Array(num2.reversed())
        let count = max(num1.count, num2.count)
        // 只用一维数组存储
        var result: [Int] = Array(repeating: 0, count: count * 2)
        
        // 以竖式的方式相乘
        for i in 0...n1.count - 1 {
            var flag = 0, temp = 1
            for j in 0...n2.count - 1 {
                temp = Int((n1[i].asciiValue! - 48) * (n2[j].asciiValue! - 48)) + flag // 当前乘积的结果 + 上一轮的进位
                temp += result[i + j] // 当前乘积的结果 + 之前乘积累加的结果
                result[i + j] = temp % 10 // 取个位
                flag = temp / 10 //取十位作为进位
            }
            result[n2.count + i] = flag // 把最后的进位加上
        }
        
        // 移除掉开头的 0
        while result.last == 0 {
            result.removeLast()
        }
        
        // 转为字符串数组，并反转+连接+输出
        let stringArray = result.map { String($0) }
        return stringArray.reversed().joined(separator: "")
    }
}
