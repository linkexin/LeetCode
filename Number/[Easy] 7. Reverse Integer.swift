// 看评论里更快的方法是每次循环都判断是不是超出了范围
class Solution {
   func reverse(_ x: Int) -> Int {
       var num = x, result = 0
       repeat {
           result = result * 10 + num % 10
           num /= 10
       } while(num != 0)
       // [−2^31,  2^31 − 1] 范围判断
       if result > 1<<31 - 1 || result < -1<<31 {
           return 0
       }
       return result
   }
}

let s = Solution()
s.reverse(2147483641) //1463847412
s.reverse(2147483647) //0
