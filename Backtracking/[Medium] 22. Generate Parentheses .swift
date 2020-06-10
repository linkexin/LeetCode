// 递归，每个递归都分别 append 左括号和右括号，然后继续递归
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
