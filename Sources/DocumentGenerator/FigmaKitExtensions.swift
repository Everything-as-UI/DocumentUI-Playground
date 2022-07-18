//
//  File.swift
//  
//
//  Created by Denis Koryttsev on 24.06.2022.
//

import Foundation
import CoreGraphics
import FigmaKit

fileprivate let camel = CharacterSet.alphanumerics.inverted
extension String {
    var leftTrimmingNumbers: String {
        firstIndex(where: { !$0.isNumber })
            .map({ String(self[$0...]) })
        ?? ""
    }
    var uncapitalized: String {
        guard count > 0 else { return "" }
        return replacingCharacters(in: ...startIndex, with: self[startIndex].lowercased())
    }
    var variableName: String {
        let charSet = CharacterSet.alphanumerics.inverted.union(.whitespacesAndNewlines)
        return components(separatedBy: charSet)
            .joined()
            .leftTrimmingNumbers
            .uncapitalized
    }
    var typeName: String {
        let charSet = CharacterSet.alphanumerics.inverted.union(.whitespacesAndNewlines)
        return components(separatedBy: charSet)
            .joined()
            .leftTrimmingNumbers
            .capitalized
    }
}

extension Node {
    var isSubview: Bool {
        switch type {
        case .vector, .frame, .instance, .rectangle, .group: return true
        default: return false
        }
    }
}

extension Collection {
    func reduce<R>(into result: R, while predicate: (Element) -> Bool, _ nextPartialResult: (inout R, Element) -> Void) -> R {
        var res = result
        for el in self {
            guard predicate(el) else { return res }
            nextPartialResult(&res, el)
        }
        return res
    }

    func flatten(_ keyPath: KeyPath<Element, Self>, filter: KeyPath<Element, Bool>, ancestors: [Element] = []) -> [(element: Element, ancestors: [Element])] {
        var res: [(element: Element, ancestors: [Element])] = []
        _reduce(into: &res, ancestors: [], keyPath: keyPath, filter: filter)
        return res
    }
    private func _reduce(into container: inout [(element: Element, ancestors: [Element])], ancestors: [Element], keyPath: KeyPath<Element, Self>, filter: KeyPath<Element, Bool>) {
        for el in self {
            guard el[keyPath: filter] else { continue }
            container.append((el, ancestors))
            el[keyPath: keyPath]._reduce(into: &container, ancestors: ancestors + [el], keyPath: keyPath, filter: filter)
        }
    }
}

extension FigmaKit.Node {
    func node<P>(at path: P) -> Node? where P: RandomAccessCollection, P.Element == String/*, P.Index == Int*/ {
        guard path.count > 0 else { return nil }
        let current = path[path.startIndex]
        return children
            .first(where: { $0.id == current })
            .flatMap { node in
                path.count > 1
                ? node.node(at: path.dropFirst())
                : node
            }
    }
}

protocol RoundedCorners {
    var cornerRadius: Double? { get }
    var rectangleCornerRadii: Node.RectangleNode.CornerRadii? { get }
}
extension Node.RectangleNode: RoundedCorners {}
extension Node.FrameNode: RoundedCorners {}

extension Node.RectangleNode.CornerRadii {
    var allEqual: Bool {
        bottomLeft == bottomRight &&
        bottomLeft == topLeft &&
        bottomLeft == topRight
    }
}
extension TypeStyle {
    var fontWeightName: String {
        switch fontWeight {
        case 100: return "ultraLight"
        case 200: return "thin"
        case 300: return "light"
        case 400: return "regular"
        case 500: return "medium"
        case 600: return "semibold"
        case 700: return "bold"
        case 800: return "heavy"
        case 900: return "black"
        default: return "\(fontWeight)"
        }
    }
}

extension Vector {
    var cgPoint: CGPoint {
        CGPoint(x: x, y: y)
    }
}
extension Rectangle {
    var cgRect: CGRect {
        CGRect(x: x, y: y, width: width, height: height)
    }
}
extension CGRect {
    func edgeInsets(from other: CGRect) -> EdgeInsets {
        EdgeInsets(top: minY - other.minY, left: minX - other.minX, bottom: maxY - other.maxY, right: maxX - other.maxX)
    }
    func inside(_ other: CGRect) -> CGRect {
        CGRect(x: minX - other.minX, y: minY - other.minY, width: width, height: height)
    }
}

extension Node {
    func name(for child: Node) -> String {
        let index = children.reduce(into: 0, while: { $0 != child }, { $0 += $1.name == child.name ? 1 : 0 })
        return child.name + (index > 0 ? "\(index)" : "")
    }
}

struct SubviewModel {
    let name: String
    let node: Node.VectorNode
    let namePath: [String]
    let subviews: [SubviewModel]
}
extension SubviewModel {
    var variableName: String {
        name.variableName + (node.type == .text ? "Label" : "View")
    }
}
extension Node {
    func generateSubviews(_ namePath: [String] = []) -> [SubviewModel] {
        var names: [String: Int] = [:]
        var subviews: [SubviewModel] = []
        for child in children {
            guard child.isSubview || child.type == .text else { continue }
            let name = names[child.name].map({ i -> String in
                let ni = i + 1
                names[child.name] = ni
                return child.name + "\(ni)"
            }) ?? {
                names[child.name] = 0
                return child.name
            }()
            let currentNamePath = namePath + ["\(name.typeName)View"]
            subviews.append(SubviewModel(name: name, node: child as! Node.VectorNode, namePath: currentNamePath, subviews: child.generateSubviews(currentNamePath)))
        }
        return subviews
    }
}
