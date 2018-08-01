//: [Previous](@previous)

import Foundation



/// 分开两个数组的 index
///
/// - Parameters:
///   - contents: <#contents description#>
///   - sortBy: <#sortBy description#>
///   - low: <#low description#>
///   - high: <#high description#>
/// - Returns: <#return value description#>
func quickSeparate<T: Comparable>(_ contents:inout [T],_ sortBy:(T,T)->Bool, low: Int, high: Int) -> Int {
    assert(contents.count > 1, "数组无需排序")
    assert(low >= 0, "下标不能小与0")
    assert(high < contents.count, "下标不能越界")
    assert(low < high, "低位不能大于高位")
    
    let pivot = contents[high] //选中一个高位
    var i = low
    for j in low..<high {//从低到高的下标区间
        if sortBy(contents[j],pivot) {//根据下标取出值
            contents.swapAt(j, i)
            i += 1
        }
        print(i)
    }
    contents.swapAt(i, high)
    print(contents)
    return i
}

func partition<T: Comparable>(_ contents:inout [T],_ sortBy:(T,T)->Bool, low: Int, high: Int) -> Int  {
    var low = low
    var high = high
    assert(contents.count > 1, "数组无需排序")
    assert(low >= 0, "下标不能小与0")
    assert(high < contents.count, "下标不能越界")
    assert(low < high, "低位不能大于高位")
    let lowValue = contents[low]
//    print(pro)
    while low < high {
        while low < high && contents[high] >= lowValue {
            high -= 1
            contents[low] = contents[high]
            print("----")
        }
        while low < high && contents[low] <= lowValue {
            low += 1
            contents[high] = contents[low]
        }
    }
     contents[low] = lowValue
    print("low: \(low)")
    print("high: \(high)")
    return low
}

func quicklySort<T: Comparable>(_ contents:inout [T],_ sortBy:(T,T)->Bool, low: Int, high: Int) {
    if low < high {
        let pivotloc = partition(&contents, sortBy, low: low, high: high)
        quicklySort(&contents, sortBy, low: low, high: pivotloc - 1)
        quicklySort(&contents, sortBy, low: pivotloc + 1, high: high)
        print(contents)
    }
}




var arr2 = [1,32,2,55,6,3,44]

print(arr2)

quicklySort(&arr2, { (v1, v2) -> Bool in
    return v1 >= v2
}, low: 0, high: arr2.count - 1)
print(arr2)


/*
 void main ( )
 {   QSort ( L, 1, L.length ); }

 void QSort ( SqList &L，int low,  int  high ) {
   if  ( low < high ) {
    pivotloc = Partition(L, low, high ) ;
    Qsort (L, low, pivotloc-1) ;
    Qsort (L, pivotloc+1, high )
  }
 }

 
 int Partition ( SqList &L，int low,  int  high ) {
  L.r[0] = L.r[low];
 pivotkey = L.r[low].key;
 while  ( low < high ) {
  while ( low < high && L.r[high].key >= pivotkey )
   --high;
 L.r[low] = L.r[high];
    while ( low < high && L.r[low].key <= pivotkey )
        ++low;
        L.r[high] = L.r[low];
 }
 L.r[low]=L.r[0];
 return low;
 }
 
 */
//while low < high && contents[high] >= pro {
//    high -= 1
//    contents[low] = contents[high]
//}//contents[low] <= pro
//while low < high && contents[low] <= pro {
//    low += 1
//    contents[high] = contents[low]
//}



