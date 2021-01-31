class Solution {
    let open: [Character] = ["(", "[", "{"]
    func isValid(_ s: String) -> Bool {
        var re = true
        var arr = [Character]()
        
        func removeLastChar() {
            arr.removeLast()
        }
        
        for character in s {
            if open.contains(character) {
                arr.append(character)
            } else {
                let c = arr.last
                switch character {
                case ")":
                    if c != "(" { re = false }
                case "]":
                    if c != "[" { re = false }
                case "}":
                    if c != "{" { re = false }
                default:
                    break
                }
                if re == false {
                    break
                } else {
                    removeLastChar()
                }
            }
        }
        if arr.isEmpty == false {
            re = false
        }
        return re
    }
}
