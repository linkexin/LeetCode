//https://leetcode-cn.com/problems/search-in-rotated-sorted-array/solution/yi-wen-dai-ni-shua-bian-er-fen-cha-zhao-dtadq/
public static int binarySearch(int[] nums,int target,int left, int right) {
   //这里需要注意，循环条件
   while (left <= right) {
       //这里需要注意，计算mid
       int mid = left + ((right - left) >> 1);
       if (nums[mid] == target) {
           return mid;
       }else if (nums[mid] < target) {
           //这里需要注意，移动左指针
           left  = mid + 1;
       }else if (nums[mid] > target) {
           //这里需要注意，移动右指针
           right = mid - 1;
       }
   }
   //没有找到该元素，返回 -1
   return -1;
}


//二分的注意点：
//1.计算 mid 时 ，不能使用 （left + right ）/ 2,否则有可能会导致溢出
//2.while (left < = right) { } 注意括号内为 left <= right ,而不是 left < right ，我们继续回顾刚才的例子，如果我们设置条件为 left < right 则当我们执行到最后一步时，则我们的 left 和 right 重叠时，则会跳出循环，返回 -1，区间内不存在该元素，但是不是这样的，我们的 left 和 right 此时指向的就是我们的目标元素 ，但是此时 left = right 跳出循环
//3.left = mid + 1,right = mid - 1 而不是 left = mid 和 right = mid。我们思考一下这种情况,见下图，当我们的target 元素为 16 时，然后我们此时 left = 7 ，right = 8，mid = left + (right - left) = 7 + (8-7) = 7，那如果设置 left = mid 的话，则会进入死循环，mid 值一直为7 。
