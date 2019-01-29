 
 

extension String {

    
    /// 翻转字符串
    /// 也可以用一个栈 按照顺序把字符串的字符压入栈 然后按栈的先进后出 输出
    /// - Parameter string: <#string description#>
    /// - Returns: <#return value description#>
    
    func reverseString(string:String) -> String {
        var temp = Array(string.characters)
        var  count:Int = temp.count
        for var i in 0..<count / 2 {
            temp.swapAt(i,count - i - 1)
        }
        return String(temp)
        
    }

}


let hello = "hellosss"

print(hello.reverseString(string: hello))

