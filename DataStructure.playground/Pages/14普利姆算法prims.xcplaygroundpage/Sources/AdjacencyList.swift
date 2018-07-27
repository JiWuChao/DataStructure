import Foundation

//邻接表
open class AdjacencyList<T: Hashable> {
    // adjacencyDict 是一个字典 key 是顶点 value 是于顶点相连的所有边
    public var adjacencyDict : [Vertex<T>: [Edge<T>]] = [:]
    public init() {}

    
    /// 获取所有顶点
    ///
    /// - Returns: <#return value description#>
    public func getAllVertices() -> [Vertex<T>] {
        return Array(adjacencyDict.keys)
    }
    
    /// 添加一个有方向的边
    ///
    /// - Parameters:
    ///   - source: 顶点
    ///   - destination: 终点
    ///   - weight: 权重
    fileprivate func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight) // 1
        adjacencyDict[source]?.append(edge) // 2
    }
    
    /// 添加一个无方向的边：无论是源点或者是终点，其对应的边点数组都要添加这条边
    ///
    /// - Parameters:
    ///   - vertices: 源点和终点
    ///   - weight: 权重
    fileprivate func addUndirectedEdge(vertices: (Vertex<Element>, Vertex<Element>), weight: Double?) {
        let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
}


extension AdjacencyList:Graphable {
    public typealias Element = T
    //为了让使用者定义一个输出的格式
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
    
    
    //提供一个通用的方法生成一个顶点
    public func createVertex(data: Element) -> Vertex<Element> {
        let vertex = Vertex(data: data) //生成一个顶点
        if adjacencyDict[vertex] == nil { //如果当前存储边的数组为 nil（即还没有初始化） 则生成一个数组
            adjacencyDict[vertex] = []
        }
        return vertex //返回顶点
    }
    
    //提供一个通用的方法 在两个顶点之间添加一条边
   public func add(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        switch type {
        case .directed://有向图
            addDirectedEdge(from: source, to: destination, weight: weight)
            break
        case .undirected://无向图
            addUndirectedEdge(vertices: (source, destination), weight: weight)
            break
        }
        
    }
    //获取两个顶点之间的权重
  public  func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? {
        //获取当前源点的所有边
        guard let edges = adjacencyDict[source] else { return nil }
        for edge in edges {// 遍历所有边
            if edge.destination == destination {//如果当前边的目的地等于要查询的目的地
                return edge.weight //则返回 权重
            }
        }
        return nil
    }
    // 获取与顶点相连的所有的边
   public func edges(from source: Vertex<Element>) -> [Edge<Element>]? {
        return adjacencyDict[source]
    }
}
