//: [Previous](@previous)

import Foundation


/*
           第一
        /   /\  \ 1
     6 /   /  \  \
    第四   /5   \3 第二
     \   /      \  |
     7\ /        \ |2
     第五 ---4--- 第三
 参考文档：https://www.raywenderlich.com/152046/swift-algorithm-club-graphs-adjacency-list
 */


let list = AdjacencyList<String>.init()

let first =  list.createVertex(data: "第一")
let second =   list.createVertex(data: "第二")
let third =   list.createVertex(data: "第三")
let forth =   list.createVertex(data: "第四")
let fifth =   list.createVertex(data: "第五")

list.add(.undirected, from: first, to: second, weight: 1)
list.add(.undirected, from: first, to: third, weight: 3)
list.add(.undirected, from: first, to: forth, weight: 6)
list.add(.undirected, from: first, to: fifth, weight: 5)
list.add(.undirected, from: forth, to: fifth, weight: 7)
list.add(.undirected, from: fifth, to: third, weight: 4)
list.add(.undirected, from: second, to: third, weight: 2)

if let edges = list.breadthFirstSearch(from: second, to: forth) {
    for edge in edges {
        print("\(edge.source) -> \(edge.destination)")
    }
}
