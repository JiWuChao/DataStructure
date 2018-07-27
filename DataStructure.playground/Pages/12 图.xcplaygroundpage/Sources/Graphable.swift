import Foundation

protocol Graphable {
    //协议需要一个称为元素的关联类型。这允许协议是通用的，可以容纳任何类型。
    associatedtype Element: Hashable //
    //为了让使用者定义一个输出的格式
    var description: CustomStringConvertible { get } // 2
    //提供一个通用的方法生成一个顶点
    func createVertex(data: Element) -> Vertex<Element> // 3
    //提供一个通用的方法 在两个顶点之间添加一条边
    func add(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    //获取两个顶点之间的权重
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
    // 获取与顶点相连的所有的边
    func edges(from source: Vertex<Element>) -> [Edge<Element>]? // 6
    
}
