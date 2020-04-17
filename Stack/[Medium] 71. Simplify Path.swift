class Solution {
    var string = ""
    func simplifyPath(_ path: String) -> String {
        string = "/"
        for character in path {
            guard let top = string.last else {
                push(character)
                continue
            }
            
            switch (top, character) {
            case ("/", "/"):
                break
            case ("/", "."):
                push(character)
            case (".", "/"):
                handlePeriodAppendSlash()
            default:
                push(character)
            }
        }
        handlePeriodAppendSlash()
        return output()
    }
    
    func push(_ x: Character) {
        string.append(x)
    }
    
    func pop() {
        if string.isEmpty == false {
            string.removeLast()
        }
    }
    
    func handlePeriodAppendSlash() {
        var tailPeriod = 0
        var temps = string
        while true {
            if temps.last == "." {
                temps.removeLast()
                tailPeriod += 1
            } else {
                break;
            }
        }
        
        switch tailPeriod {
        case 1:
            pop()
        case 2:
            backLastSlash()
        default:
            push("/")
        }
    }
    
    func dealSlashIfneeded() {
        while string.last == "/" {
            pop()
        }
        if string.first != "/" {
            string = "/" + string
        }
    }
    
    func backLastSlash () {
        while string.last == "." || string.last == "/" {
            pop()
        }
        while string.last != "/" && string.isEmpty == false {
            pop()
        }
    }
    
    func output() -> String {
        dealSlashIfneeded()
        return string
    }
}

let s = Solution()
// 有几个注意的点：
// 1. "..." 是合法文件名，无论在中间还是在结尾
// 2. 结尾的 ".." 也算是返回上级，我之前以为一定要是 "../"
s.simplifyPath("/a//b////c/d//././/....")  //"/a/b/c/d/...."
s.simplifyPath("/home/")  //"/home"
s.simplifyPath("/home//foo/_")  //"/home/foo/_"
s.simplifyPath("d/..")  //"/"
s.simplifyPath("a//b////c/d//././/../") // "/a/b/c"
s.simplifyPath("/../")  // "/"
s.simplifyPath("/...")  //"/..."
s.simplifyPath("/a/./b/../../c/")  //"/c"
s.simplifyPath("/a/../../b/../c//.//")  //"/c"
s.simplifyPath("../.././././../a/../../b/../c//.//..")  //"/"
s.simplifyPath("../.././././..////////////../././././.../..")  //"/"
s.simplifyPath("a//b////c/d//e/fff//////h././/.././././../../..///../../././..////.")  //"/"
s.simplifyPath("a//b////c/d//e/fff//////h././/.././././../../..///../../././..////a/")  //"/a"
