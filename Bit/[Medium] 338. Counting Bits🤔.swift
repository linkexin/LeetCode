// O(n*sizeof(integer))，遍历 num，每次都重新计算 num 的 1 的个数
class Solution {
    func countBits(_ num: Int) -> [Int] {
        guard num > 0 else {
            return [0]
        }
        var bits = Array.init(repeating: 0, count: num + 1)
        for i in 1 ... num {
            bits[i] = countBit(i)
        }
        return bits
    }
    
    func countBit(_ num: Int) -> Int {
        var n = num, bits = 0
        while n != 0 {
            bits += 1
            n = n & (n - 1)
        }
        return bits
    }
}

// O(N) 解法，利用位运算作下标，感觉很巧妙
class Solution {
    func countBits(_ num: Int) -> [Int] {
        guard num > 0 else {
            return [0]
        }
        var bits = Array.init(repeating: 0, count: num + 1)
        for i in 1 ... num {
            // i & (i - 1) 是 i 去掉最后一个 1 的结果，所以一定比 i 小，
            // 计算 bits[i] 的时候，bits[i & (i - 1)] 一定有值
            bits[i] = bits[i & (i - 1)] + 1
        }
        return bits
    }
}
