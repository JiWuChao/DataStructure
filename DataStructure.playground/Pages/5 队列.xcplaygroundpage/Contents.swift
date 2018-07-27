//: [Previous](@previous)

import Foundation

public struct Queue<T> {
    fileprivate var queueData = [T]()

    public var count:Int {
        return queueData.count
    }
    
    public var isEmpty : Bool {
        return queueData.isEmpty
    }
    
    public mutating func enqueue(elment:T) {
        queueData.append(elment)
    }
    
    public mutating func enqueueAll(elments:[T]) {
        for element in elments {
            queueData.append(element)
        }
    }
    
    
    
    public mutating func dequeue() {
        if !isEmpty {
            queueData.removeFirst()
        }
    }
    
    public var font:T {
        return queueData.first!
    }
    
}

extension Queue:CustomStringConvertible {
    public var description: String {
        var s = "["
        for (index,value) in queueData.enumerated() {
            s += "\(value)"
            if index != count - 1 {
                s += ","
            }
        }
        return s + "]"
    }
    
    
}



var queue = Queue<String>.init()
    
    queue.enqueue(elment: "aaaa")
    queue.enqueue(elment: "bbbb")
    queue.enqueue(elment: "cccc")
    queue.enqueueAll(elments: ["hshsh","sss","wwww","http"])
    print(queue)

    queue.dequeue()

    print(queue)
