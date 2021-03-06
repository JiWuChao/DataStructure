//: [Previous](@previous)

import Foundation



class Prim<T:Hashable> {
    
    typealias Graph = AdjacencyList<T>
    //定义一个小堆
    var heap = Heap<(vertex:Vertex<T>,weight:Double,parent:Vertex<T>?)>.init { (vertex, vertex2) -> Bool in
        return vertex.weight < vertex2.weight
    }
    
    /// 生成最小生成树
    ///
    /// - Parameter graph: <#graph description#>
    /// - Returns: <#return value description#>
    func createMinimumSpanningTree(graph:Graph) -> (cost:Double,mst:Graph) {
        var cost = 0.0
        let mst = Graph()
        var visited = Set<Vertex<T>>()
        
        guard let start = graph.getAllVertices().first else{
            print(mst.description)
            return (cost:cost,mst:mst)
        }
        //先把开始的顶点加入到堆中
        heap.enqueue((vertex: start, weight: 0.0, parent: nil))
        
        while let head = heap.dequeue() {
            let vertex = head.vertex //取出堆中的第一个顶点
            if visited.contains(vertex) {//检查是否已经访问过了 如果已经访问过了 则进行下一次循环
                continue
            }
            visited.insert(vertex)
            cost += head.weight
            if let prev = head.parent { // 5
                let pre = mst.createVertex(data: prev.data)
                let ver = mst.createVertex(data: vertex.data)
                mst.add(.undirected, from: pre, to: ver, weight: head.weight)
            }
            
            if let neighbours = graph.edges(from: vertex) {
                for neighbour in neighbours {
                    if !visited.contains(neighbour.destination) {
                        heap.enqueue((vertex: neighbour.destination, weight: neighbour.weight ?? 0, parent: vertex))
                    }
                }
            }
        }
        return (cost:cost,mst:mst)
    }
}


/*
        第一
     /   /\  \ 1
  6 /   /  \  \
 第四   /5   \3 第二
  \   /      \  |
  7\ /        \ |2
  第五 ---4--- 第三
 
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




let prim = Prim<String>.init()
let (cost,mst) = prim.createMinimumSpanningTree(graph: list)

print("权值:\(cost)")
print("最小生成树:")

print(mst.description)




