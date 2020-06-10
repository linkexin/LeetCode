// 递归，每个递归都分别 append 左括号和右括号，然后继续递归
// 对应官方题解的第二种解法
// faster than 29.05%
class Solution {
    func generateParenthesis(_ n: Int) -> [String] {
        return recursion(n, n, str: "")
    }
    
    func recursion(_ leftCount: Int, _ rightCount: Int, str: String) -> [String] {
        if leftCount == 0 && rightCount == 0 {
            return [str]
        }
        var re1 = [String](), re2 = [String]()
        if leftCount > 0 {
            re1 = recursion(leftCount - 1, rightCount, str: str + "(")
        }
        if rightCount > 0 && leftCount < rightCount {
            re2 = recursion(leftCount, rightCount - 1, str: str + ")")
        }
        return re1 + re2
    }
}

// 同样的思路，只是递归的参数加了一个 inout 的 result，时间提升不少
// faster than 95.27%
class Solution1 {
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]()
        recursion(&result, n, n, str: "")
        return result
    }
    
    func recursion(_ result: inout [String], _ leftCount: Int, _ rightCount: Int, str: String) {
        if leftCount == 0 && rightCount == 0 {
            result.append(str)
            return
        }
        if leftCount > 0 {
            recursion(&result, leftCount - 1, rightCount, str: str + "(")
        }
        if rightCount > 0 && leftCount < rightCount {
            recursion(&result,leftCount, rightCount - 1, str: str + ")")
        }
    }
}
