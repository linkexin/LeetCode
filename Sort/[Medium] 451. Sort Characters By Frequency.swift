// faster than 92.65%
class Solution {
    // 快排
    func sort(_ sta: Int, _ end: Int, _ arr: inout [Character], _ dic: [Character: Int]) {
        if sta >= end {
            return
        }
        let pivot = partition(sta, end, &arr, dic)
        sort(sta, pivot - 1, &arr, dic)
        sort(pivot + 1, end, &arr, dic)
    }
    
    func partition(_ sta: Int, _ end: Int, _ arr: inout [Character], _ dic: [Character: Int]) -> Int {
        var index = sta
        for i in sta ..< end {
            if dic[arr[i]] ?? 0 > dic[arr[end]] ?? 0 {
                swap(i, index, &arr)
                index += 1
            }
        }
        swap(end, index, &arr)
        return index
    }
    
    func swap(_ index1: Int, _ index2: Int, _ arr: inout [Character]) {
        let temp = arr[index1]
        arr[index1] = arr[index2]
        arr[index2] = temp
    }
    
    func frequencySort(_ s: String) -> String {
        // 先循环一次把每个字符出现的次数统计出来
        // 后续再根据字典中字符对应的出现次数来排序
        var dic = [Character: Int]()
        for c in s {
            dic[c, default: 0] += 1
        }
        var arr = Array(dic.keys)
        sort(0, arr.count - 1, &arr, dic)
        
        var string = ""
        for c in arr {
            for _ in 0 ..< (dic[c] ?? 0) {
                string.append(c)
            }
        }
        return string
    }
}

// 用系统的 sort 方法简化写法
// faster than 97.87%
class Solution1 {
    func frequencySort(_ s: String) -> String {
        // 先循环一次把每个字符出现的次数统计出来
        // 后续再根据字典中字符对应的出现次数来排序
        var dic = [Character: Int]()
        for c in s {
            dic[c, default: 0] += 1
        }
        var arr = Array(dic.keys)
        arr.sort { (c1, c2) -> Bool in
            return dic[c1] ?? 0 > dic[c2] ?? 0
        }
        
        var string = ""
        for c in arr {
            for _ in 0 ..< (dic[c] ?? 0) {
                string.append(c)
            }
        }
        return string
    }
}
