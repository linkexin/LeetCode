class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count <= 1 {
            return nums.count
        }
        for i in (1...nums.count - 1).reversed()  {
            if nums[i] == nums[i - 1] {
                nums.remove(at: i)
            }
        }
        return nums.count
    }
}

let s = Solution()
var arr = [1,1,2]
s.removeDuplicates(&arr)
