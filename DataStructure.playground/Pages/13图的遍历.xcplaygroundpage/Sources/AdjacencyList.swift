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
                /*
                    用字典 记录已经访问过的顶点用于记录访问的路径
                    键:顶点
                    值:一个枚举值
                         enum Visit<Element: Hashable> {
                            case source 原点
                            case edge(Edge<Element>) 边
                         }
                 */
                 var visits : [Vertex<Element> : Visit<Element>] = [source: .source]
                while let visitedVertex = queue.dequeue() { // 2遍历取出然后取出出队的元素
                    if visitedVertex == destination { // 3如果源点和终点相同
                        var vertex = destination //
                        var route: [Edge<Element>] = []// 访问的路径
                        
                        while let visit = visits[vertex],
                            case .edge(let edge) = visit {
                                route = [edge] + route
                                vertex = edge.source
                                
                        }
                        return route
                    }
                    /*
                     1 取出跟原点相关的所有边
                     2 遍历跟原点相关的所有边 --> 找到边的终点
                     3 判断：如果边的终点没有被访问过：即邻接点还没有被访问过
                     4 把此邻接点加入队列
                     5 把邻接点标记为已访问
                     */
                    let neighbourEdges = edges(from: visitedVertex) ?? [] // 1
                    for edge in neighbourEdges {//2
                        if visits[edge.destination] == nil {//3
                            queue.enqueue(edge.destination)//4
                            visits[edge.destination] = .edge(edge)//5
                        }
                        print("\(edge.destination)")
                    }
                    print("---end---\n")
                }
                return nil
    }
    
    

    public func depthFirstSearch(from source: Vertex<Element>, to destination: Vertex<Element>)
        -> [Edge<Element>]?  {
            // 之所以用队列的原因就是 深度优先算法需要回退
            var stack = Stack<Vertex<Element>>() // 创建一个堆栈来存储从起点到终点的潜在路径。
                stack.push(source)//把开始的顶点压入栈
             var visits : [Vertex<Element> : Visit<Element>] = [source: .source]//存储已经访问过的顶点
             while let vertex = stack.pop()  {
                if vertex == destination { // 如果源点和终点相同
                    var vertex = destination //
                    var route: [Edge<Element>] = []// 访问的路径
                    while let visit = visits[vertex],
                        case .edge(let edge) = visit {
                            route = [edge] + route
                            vertex = edge.source
                    }
                    return route
                }
                
                guard let neighbors = self.edges(from: vertex), neighbors.count > 0 else {
                    _ = stack.pop()
                    continue
                }
                
                for edge in neighbors {
                    if visits[edge.destination] == nil {
                        stack.push(edge.destination)
                        visits[edge.destination] = .edge(edge)
                    }
                }
            }
            return nil
    }
}

