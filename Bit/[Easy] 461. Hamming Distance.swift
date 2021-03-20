class Solution {
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var count = 0
        var x = x, y = y
        while x != 0 && y != 0 {
            if x & 1 != y & 1 {
                count += 1
            }
            x >>= 1
            y >>= 1
        }
        while x != 0 {
            // 注意需要此位为 1，count 才 ++
            if x & 1 == 1 {
                count += 1
            }
            x >>= 1
        }
        while y != 0 {
            if y & 1 == 1 {
                count += 1
            }
            y >>= 1
        }
        return count
    }
}
