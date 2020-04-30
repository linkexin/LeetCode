// 使用了官方题解中的第二种思路，但是实现上有点不一样
// https://leetcode-cn.com/problems/zigzag-conversion/solution/z-zi-xing-bian-huan-by-leetcode/
class Solution {
    func convert(_ s: String, _ numRows: Int) -> String {
        if numRows <= 1 {
            return s
        }
        let letter = Array(s)
        var string = [Character]()
        let step = 2 * numRows - 2 // 每跨一步的步幅
        var jm = s.count / step
        if s.count % step != 0 {
            jm += 1
        }
        // 输出 numRows 行
        for i in 0 ... numRows - 1 {
            // 每行以 jm 为跨度向后遍历输出，注意下标的合法性判断
            for j in 0 ... jm {
                let stepL = step * j - i
                let stepR = step * j + i
                if stepL >= 0 && stepL < s.count && i != numRows - 1 {
                    string.append(letter[step * j - i])
                }
                if stepR < s.count && i != 0 {
                    string.append(letter[step * j + i])
                }
            }
        }
        
        return String(string)
    }
}
