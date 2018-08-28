//: [Previous](@previous)

import Foundation


/*
 快速排序：
 
 基本思想：
 
 任取一个元素 (如第一个) 为中心
 所有比它小的元素一律前放，比它大的元素一律后放，形成左右两个子表；
 对各子表重新选择中心元素并依此规则调整，直到每个子表的元素只剩一个
 ①每一趟的子表的形成是采用从两头向中间交替式逼近法；
 
 ②由于每趟中对各子表的操作都相似，可采用递归算法。
 
 */
func quicklySort<T: Comparable>(_ contents:inout [T], low: Int, high: Int) {
    var i = low
    var j = high
    guard low < high,low >= 0,high < contents.count  else {
        return
    }
    let piv = (low + (high - low) / 2)//标志位
    let lowValue = contents[piv] //
    
    /*
     一个循环的流程
     
     
     从高位（右边）开始：
     1 循环判断 当前高位的值是否大于标志位值 如果大于 则再向前一位比较 一直找到小于标志位的index
     2 高位找到比标志位的值小的index 之后 停止开始从低位（左边）开始
     
     低位开始 ：
     
     1 循环判断 当前低位的值是否小于标志位 如果小于标志位则index + 1 进行下一位比较，直到找到比标志位大的值
     2 低位找到比标志位大的值之后停止
     
     交换：
     
     从低位和高位找到了 比标志位大的值和比标志位小的值 然后这两个值交换
     
     当i >= j 即低位的index >= 高位的index时 停止这一轮的循环
     
     */
    
    print("\n标志位")
    print(lowValue)
    
    while i < j {
        while contents[j] >  lowValue {
            j -= 1//高位的 index - 1
        }
        while contents[i] < lowValue {
            i += 1
        }
        if i <= j  {
           contents.swapAt(i, j)
          print("contenti-->\(contents[i])" +  "和" +  " contentj-->\(contents[j])" + "交换")
            /*
                交换完成后 i 向下一步
                j 向前一步
             */
            i += 1
            j -= 1
        }
    }
    print("本轮排序结果:\n\(contents)")
    print("\n----------下一轮分割线--------------")
    print("low = \(low),high = \(high), i = \(i),j = \(j)")
    if low < j {
        print("\n----------左边--------------")
        quicklySort(&contents, low: low, high: j)
    }
    if i < high {
        print("\n----------右边--------------")
        quicklySort(&contents, low: i, high: high)
    }
}


var arr2 = [7,32,2,1,5]
print("初始化数组")
print(arr2)
quicklySort(&arr2, low: 0, high: arr2.count - 1)




