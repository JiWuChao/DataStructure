import UIKit

/*
    问题：
 
 
 
 
 */



/*
    环境 ：
    Xcode playground 10.1
    Swift 4.2

 */

enum  InputIPAddressError: Error {
    case moreSegment    // 非4段
    case tooBig    // 数值越界
    case hasSpec    // "1[Space]72.168.5.1" 有空格
}


func hasSpecInMidOfString( str: String) throws -> Int {
    let trimmingString = str.trimmingCharacters(in: CharacterSet.init(charactersIn: " "))
    let rang = trimmingString.range(of: " ")
    
    guard rang == nil else {
        throw InputIPAddressError.hasSpec
    }
    return Int(trimmingString) ?? 0
}


func convertIpv4ToInt(ipAddress:String) throws -> UInt32 {
    
    let segments = ipAddress.components(separatedBy: ".")
    
    var value = 0
    
    guard segments.count == 4 else {
        throw InputIPAddressError.moreSegment
    }
    
    for segmentValue in segments {
        var sValue = 0
        
        do {
            sValue = try hasSpecInMidOfString(str: segmentValue)
        } catch InputIPAddressError.hasSpec {
            throw InputIPAddressError.hasSpec
        }
        
        guard sValue <= UInt8.max && sValue >= UInt8.min else {
            throw InputIPAddressError.tooBig
        }
        
        value = value << 8 + sValue
    }
    
    return UInt32(value)
}

// ------------ Test ----------


let test0 = "172 . 168.5.1"//Well done:2896692481

let test1 = "1 72.168.5.1"//Illegal,hasSpec

let test2 = "172.168.5.1"//Well done:2896692481


do {
    let value = try convertIpv4ToInt(ipAddress: test2)
    print("Well done:" + "\(value)")
} catch InputIPAddressError.moreSegment {
    print("Illegal,moreSegment")
} catch InputIPAddressError.hasSpec {
    print("Illegal,hasSpec")
} catch InputIPAddressError.tooBig {
    print("Illegal,tooBig")
}


