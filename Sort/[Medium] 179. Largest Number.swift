// 这个题本质上是个排序题，只不过要自定义排序算法
// 一开始想的比较方法是，从高位到低位分别比较两个数的每一位数组，但是这就要考虑末尾是 0，和其他一些情况，比较复杂一些
// 于是换了一种比较方式，直接计算 num1num2 和 num2num1 哪个更大，比如 12 和 121，看 12121 和 12112 哪个比较大
class Solution {
    // 用一个数组来存放每个数的位数
    var digits = [Int: Int]()
    
    // 计算位数
    func calDigits(_ n: Int) {
        var num = n, count = 1
        while num > 0 {
            count *= 10
            num /= 10
        }
        digits[n] = count
    }
    
    func priotiry(_ num1: Int, _ num2: Int) -> Bool {
        // 如果有一个数字为 0，那么 0 肯定是较小的数
        // 因为单独的 0 要尽量往后放
        if num1 == 0 {
            return false
        }
        if num2 == 0 {
            return true
        }
        if digits[num1] == nil {
            calDigits(num1)
        }
        if digits[num2] == nil {
            calDigits(num2)
        }
        // 比较 num1num2 和 num2num1 哪个更大
        let n1 = num1 * (digits[num2] ?? 1) + num2
        let n2 = num2 * (digits[num1] ?? 1) + num1
        if n1 > n2 {
            return true
        }
        return false
    }
    
    func swap(_ index1: Int, index2: Int, _ nums: inout [Int]) {
        let temp = nums[index1]
        nums[index1] = nums[index2]
        nums[index2] = temp
    }
    
    // 判断数据中是否全是 0
    func judgeNonZero(_ nums: [Int]) -> Bool {
        for i in 0 ..< nums.count {
            if nums[i] != 0 {
                return true
            }
        }
        return false
    }
    
    func largestNumber(_ nums: [Int]) -> String {
        guard judgeNonZero(nums) else {
            return "0"
        }
        var nums = nums
        // 选择排序
        for i in 0 ..< nums.count {
            var maxIndex = i
            var maxValue = nums[i]
            for j in i + 1 ..< nums.count {
                if priotiry(nums[j], maxValue) {
                    maxValue = nums[j]
                    maxIndex = j
                }
            }
            swap(i, index2: maxIndex, &nums)
        }
        
        return nums.map({"\($0)"}).joined(separator:"")
    }
}

let s = Solution()
print(s.largestNumber([10,2]))
print(s.largestNumber([12,121]))
print(s.largestNumber([3,30,34,5,9]))
print(s.largestNumber([3,303,34]))
print(s.largestNumber([0,9,8,7,6,5,4,3,2,1]))
print(s.largestNumber([0,90,0])) // 特殊 case
print(s.largestNumber([0,0])) // 特殊 case
