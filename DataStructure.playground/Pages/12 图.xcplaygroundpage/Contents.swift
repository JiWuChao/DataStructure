//: [Previous](@previous)

import Foundation



// MARK: 定点
public struct Vertex<T:Hashable> {
    var data :T
}

extension Vertex:Hashable {
    
    public var hashValue: Int {
        return "\(data)".hashValue
    }
    
    static public func == (lhs:Vertex,rhs:Vertex) -> Bool {
        return lhs.data == rhs.data
    }
    
}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(data)"
    }
}

// 边

public enum EdgeType {
    case directed // 有方向的
    case undirected // 无方向的
}

public struct Edge<T:Hashable> {
    public var source:Vertex<T> //原点
    public var destination:Vertex<T>//目的地
    public let weight: Double? //权重
}

extension Edge :Hashable {
    
    public var hashValue: Int {
        return "\(source)\(destination)\(weight)".hashValue
    }
    
    static public func == (lhs:Edge<T>,rhs:Edge<T>) -> Bool {
        return lhs.source == rhs.source && lhs.destination == rhs.destination && lhs.weight == rhs.weight
    }

}



