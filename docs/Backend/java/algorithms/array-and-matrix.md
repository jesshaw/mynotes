# 数组与矩阵类

## 1. 两数之和（Two Sum）

**问题描述：**

给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那两个整数，并返回他们的数组下标。
你可以假设每种输入只会对应一个答案。但是，同一个元素不能被重复利用。

**示例：**

```bash
输入: nums = [2, 7, 11, 15], target = 9
输出: [0, 1]
解释: 因为 nums[0] + nums[1] == 9, 我们返回 [0, 1]。
```

**解答：**
使用HashMap实现时间复杂度为O(n)

```java
import java.util.HashMap;
import java.util.Map;
public class Solution {
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();        
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];            
            if (map.containsKey(complement)) {
                return new int[] { map.get(complement), i };
            }            
            map.put(nums[i], i);
        }        
        throw new IllegalArgumentException("No two sum solution");
    }
}
```

## 2. 三数之和（Three Sum）

**问题描述：**
给定一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a, b, c ，使得 a + b + c = 0 ？找出所有满足条件且不重复的三元组。

注意：答案中不可以包含重复的三元组。

**示例：**

例如，给定数组 nums = [-1, 0, 1, 2, -1, -4]，

满足要求的三元组集合为：

```bash
[
  [-1, 0, 1],
  [-1, -1, 2]
]
```

**解答：**
先排序，后选一个数，另两个数用指针移动

```java
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Solution {
    public List<List<Integer>> threeSum(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        Arrays.sort(nums); // 对数组进行排序
        
        for (int i = 0; i < nums.length - 2; i++) {
            // 跳过重复的元素
            if (i > 0 && nums[i] == nums[i - 1]) {
                continue;
            }
            
            int left = i + 1, right = nums.length - 1;
            while (left < right) {
                int sum = nums[i] + nums[left] + nums[right];
                if (sum < 0) {
                    left++; // 和太小了，需要增加左指针来增大总和
                } else if (sum > 0) {
                    right--; // 和太大了，需要减少右指针来减小总和
                } else {
                    // 找到一个解
                    result.add(Arrays.asList(nums[i], nums[left], nums[right]));
                    
                    // 跳过重复的元素
                    while (left < right && nums[left] == nums[left + 1]) {
                        left++;
                    }
                    while (left < right && nums[right] == nums[right - 1]) {
                        right--;
                    }
                    
                    // 移动指针
                    left++;
                    right--;
                }
            }
        }
        
        return result;
    }
}
```

## 3. 四数之和（4Sum）

**问题描述：**

给定一个包含 n 个整数的数组 nums 和一个目标值 target，判断 nums 中是否存在四个元素 a, b, c, d ，使得 a + b + c + d = target ？找出所有满足条件且不重复的四元组。

注意：答案中不可以包含重复的四元组。

**示例：**

例如，给定数组 nums = [1, 0, -1, 0, -2, 2] 和目标值 target = 0，

满足要求的四元组集合为：

```bash
[
  [-2, -1, 1, 2],
  [-2, 0, 0, 2],
  [-1, 0, 0, 1]
]
```

**解答：**

先排序，后第1层选一个数，第2层循环选一个数，另两个数用指针移动

```java
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Solution {
    public List<List<Integer>> fourSum(int[] nums, int target) {
        List<List<Integer>> result = new ArrayList<>();
        Arrays.sort(nums); // 对数组进行排序
        
        for (int i = 0; i < nums.length - 3; i++) {
            // 跳过重复的元素
            if (i > 0 && nums[i] == nums[i - 1]) {
                continue;
            }
            
            for (int j = i + 1; j < nums.length - 2; j++) {
                // 跳过重复的元素
                if (j > i + 1 && nums[j] == nums[j - 1]) {
                    continue;
                }
                
                int left = j + 1, right = nums.length - 1;
                while (left < right) {
                    int sum = nums[i] + nums[j] + nums[left] + nums[right];
                    if (sum < target) {
                        left++; // 和太小了，需要增加左指针来增大总和
                    } else if (sum > target) {
                        right--; // 和太大了，需要减少右指针来减小总和
                    } else {
                        // 找到一个解
                        result.add(Arrays.asList(nums[i], nums[j], nums[left], nums[right]));
                        
                        // 跳过重复的元素
                        while (left < right && nums[left] == nums[left + 1]) {
                            left++;
                        }
                        while (left < right && nums[right] == nums[right - 1]) {
                            right--;
                        }
                        
                        // 移动指针
                        left++;
                        right--;
                    }
                }
            }
        }
        
        return result;
    }
}
```

## 4. 盛水最多的容器（Container With Most Water）

**问题描述：**

给定一个长度为 n 的整数数组 height，其中每个数代表坐标轴中的一个点的高度。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。

**示例：**

例如，给定数组 height = [1,8,6,2,5,4,8,3,7]，最大容器的面积为 49。

**解答：**

高度因为是盛水，所以取小的值，宽度为两根柱子这间的距离即索引之差

```java
class Solution {
    public int maxArea(int[] height) {
        int maxArea = 0;
        int left = 0;
        int right = height.length - 1;
        
        while (left < right) {
            // 计算当前容器的面积
            int currentArea = Math.min(height[left], height[right]) * (right - left);
            
            // 更新最大面积
            maxArea = Math.max(maxArea, currentArea);
            
            // 移动较矮的那个指针
            if (height[left] < height[right]) {
                left++;
            } else {
                right--;
            }
        }
        
        return maxArea;
    }
}
```

## 5. 删除排序数组中的重复项（Remove Duplicates from Sorted Array）

**问题描述：**

**示例：**

```bash
```

**解答：**

```java

```

## 6. 买卖股票的最佳时机（Best Time to Buy and Sell Stock）

**问题描述：**

**示例：**

```bash
```

**解答：**

```java

```

## 7. 最大子数组和（Maximum Subarray）

## 8. 旋转数组（Rotate Array）

## 9. 合并两个有序数组（Merge Sorted Array）

## 10. 数组中第K个最大元素（Kth Largest Element in an Array）

## 11. 在排序数组中查找元素的第一个和最后一个位置（Find First and Last Position of Element in Sorted Array）

## 12. 搜索旋转排序数组（Search in Rotated Sorted Array）

## 13. 颜色分类（Sort Colors）

## 14. 合并区间（Merge Intervals）

## 15. 子集（Subsets）

## 16. 组合总和（Combination Sum）

## 17. 全排列（Permutations）

## 18. 矩阵置零（Set Matrix Zeroes）

## 19. 螺旋矩阵（Spiral Matrix）

## 20. 螺旋矩阵 II（Spiral Matrix II）
