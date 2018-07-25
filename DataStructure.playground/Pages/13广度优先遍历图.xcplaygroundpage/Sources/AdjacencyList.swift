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
        
      public func breadthFirstSearch(from source: Vertex<Element>, to destination: Vertex<Element>)
            -> [Edge<Element>]? {
                var queue = GraphaQueue<Vertex<Element>>()
                queue.enqueue(source) // 1先把源点加入队列
                 var visits : [Vertex<Element> : Visit<Element>] = [source: .source] // 1 //  已经访问过的定点
                while let visitedVertex = queue.dequeue() { // 2遍历取出然后取出出队的元素
                    if visitedVertex == destination { // 3如果源点和终点相同
                        var vertex = destination // 1
                        var route: [Edge<Element>] = [] // 2
                        
                        while let visit = visits[vertex],
                            case .edge(let edge) = visit { // 3
                                route = [edge] + route
                                vertex = edge.source // 4
                                
                        }
                        return route // 5
                    }
                    let neighbourEdges = edges(from: visitedVertex) ?? [] // 1 把源点的的邻接点
                    for edge in neighbourEdges {
                        if visits[edge.destination] == nil { // 2
                            queue.enqueue(edge.destination)
                            visits[edge.destination] = .edge(edge) // 3
                        }
                    } // 2
                    
        }
                return nil
    }
}

