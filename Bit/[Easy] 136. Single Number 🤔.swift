// 利用异或运算，A 异或 B 两次，结果还是 A
// A^B^B = A^(B^B) = A^0 = A
class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        var result = 0
        for n in nums {
            result ^= n
        }
        return result
    }
}
