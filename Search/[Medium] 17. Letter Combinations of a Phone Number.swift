// 深搜
class Solution {
    // key 定义成 Character 比较方便下面使用
    let match: [Character: [String]] =
        ["2": ["a", "b", "c"],
         "3": ["d", "e", "f"],
         "4": ["g", "h", "i"],
         "5": ["j", "k", "l"],
         "6": ["m", "n", "o"],
         "7": ["p", "q", "r", "s"],
         "8": ["t", "u", "v"],
         "9": ["w", "x", "y", "z"]]
    
    func letterCombinations(_ digits: String) -> [String] {
        var result = [String]()
        let string = Array(digits)
        resursion(string, 0, "", &result)
        return result
    }
    
    func resursion(_ string: [Character], _ index: Int, _ result: String, _ results: inout [String]) {
        if index >= string.count {
            if result.count > 0 {
                results.append(result)
            }
            return
        }
        guard let chars = match[string[index]] else {
            return
        }
        for c in chars {
            resursion(string, index + 1, result.appending(c), &results)
        }
    }
}
