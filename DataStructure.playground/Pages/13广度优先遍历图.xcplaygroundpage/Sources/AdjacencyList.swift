import Foundation

open class AdjacencyList<T: Hashable> {
  
      public var adjacencyDict : [Vertex<T>: [Edge<T>]] = [:]
      public init() {}
    
      fileprivate func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencyDict[source]?.append(edge)
      }
    
      fileprivate func addUndirectedEdge(vertices: (Vertex<Element>, Vertex<Element>), weight: Double?) {
        let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
      }
    }

    extension AdjacencyList: Graphable {
      
      public typealias Element = T
      
      public func createVertex(data: Element) -> Vertex<Element> {
        let vertex = Vertex(data: data)
        
        if adjacencyDict[vertex] == nil {
          adjacencyDict[vertex] = []
        }
        
        return vertex
      }
      
      public func add(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        switch type {
        case .directed:
          addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
          addUndirectedEdge(vertices: (source, destination), weight: weight)
        }
      }
      
      public func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? {
        guard let edges = adjacencyDict[source] else {
          return nil
        }
        
        for edge in edges {
          if edge.destination == destination {
            return edge.weight
          }
        }
        
        return nil
      }
      
      
      public func edges(from source: Vertex<Element>) -> [Edge<Element>]? {
        return adjacencyDict[source]
      }
      
        
      public var description: CustomStringConvertible {
        var result = ""
        for (vertex, edges) in adjacencyDict {
          var edgeString = ""
          for (index, edge) in edges.enumerated() {
            if index != edges.count - 1 {
              edgeString.append("\(edge.destination), ")
            } else {
              edgeString.append("\(edge.destination)")
            }
          }
          result.append("\(vertex) ---> [ \(edgeString) ] \n ")
        }
        return result
      }
        
        /*
         1任意取图中的一个顶点访问，入队，并将这个顶点标记为已访问
         2 当队列不为空的时候执行循环：出队，依次检查出队顶点的所有邻接顶点，访问没有被访问的邻接顶点并将其入队
         3 当队列为空的时候跳出循环，广度优先搜索完毕
         
         */
        
        
      public func breadthFirstSearch(from source: Vertex<Element>, to destination: Vertex<Element>)
            -> [Edge<Element>]? {
                var queue = GraphaQueue<Vertex<Element>>()
                    queue.enqueue(source) // 1先把源点加入队列
                    print("\(source.data)" + "hahha")
                 var visits : [Vertex<Element> : Visit<Element>] = [source: .source] //  记录已经访问过的顶点
                while let visitedVertex = queue.dequeue() { // 2遍历取出然后取出出队的元素
//                    print("\(visitedVertex.data)" + "shu")
                    if visitedVertex == destination { // 3如果源点和终点相同
                        var vertex = destination //
                        var route: [Edge<Element>] = []//路径
                        
                        while let visit = visits[vertex],
                            case .edge(let edge) = visit {
                                route = [edge] + route
                                vertex = edge.source
                                
                        }
                        return route
                    }
                    let neighbourEdges = edges(from: visitedVertex) ?? [] // 把源点的的邻接点
                    for edge in neighbourEdges {
                        if visits[edge.destination] == nil {
                            queue.enqueue(edge.destination)
                            visits[edge.destination] = .edge(edge)
                        }
                    }
                }
                return nil
    }
}

