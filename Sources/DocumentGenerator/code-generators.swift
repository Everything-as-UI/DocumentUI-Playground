//
//  Created by Denis Koryttsev on 24.06.2022.
//

import Foundation
import CoreFoundation
import CoreGraphics
import DocumentUI

#if os(macOS)
typealias EdgeInsets = NSEdgeInsets
#else
import UIKit
typealias EdgeInsets = UIEdgeInsets
#endif

struct CodeBlock<Definition, Args, Body>: TextDocument where Definition: TextDocument, Args: TextDocument, Body: TextDocument {
    @TextDocumentBuilder let definition: Definition
    @TextDocumentBuilder let args: Args
    @TextDocumentBuilder let body: Body
    var textBody: some TextDocument {
        "\(definition.suffix(" ")){\(args.prefix(" "))\(_body)}"
    }
    var _body: some TextDocument {
        body.modifiable(whenContent: { $0.count > 0 })
            .indent(4)
            .prefix("\n")
            .suffix("\n")
    }
}
enum Keyword: String {
    case `class`, `enum`, `extension`, `func`, `protocol`, `struct`
    case `fileprivate`, `internal`, `private`, `public`, `open`
    case `let`, `var`
    case `lazy`, `static`
}
extension Keyword: TextDocument {
    var textBody: some TextDocument { rawValue }
}

///

struct Class<Inherit, Properties, Functions>: TextDocument where Inherit: TextDocument, Properties: TextDocument, Functions: TextDocument {
    let name: String
    @TextDocumentBuilder let inherit: Inherit
    @TextDocumentBuilder let properties: Properties
    @TextDocumentBuilder let functions: Functions
    var textBody: some TextDocument {
        CodeBlock { "\(Keyword.class) \(name)\(inherit.prefix(": "))" } args: {} body: {
            Joined(separator: "\n") {
                properties
                functions
            }
        }
    }
}
struct _KeyValue<Key, Sign, Value>: TextDocument where Sign: TextDocument, Key: TextDocument, Value: TextDocument {
    let key: Key
    let sign: Sign
    let value: Value
    var textBody: some TextDocument {
        "\(key)\(sign)\(value)"
    }
}

protocol StaticTextDocument: TextDocument {
    associatedtype StaticTextBody where StaticTextBody == TextBody
    @TextDocumentBuilder static var textBody: StaticTextBody { get }
    init()
}
extension StaticTextDocument {
    var textBody: TextBody { Self.textBody }
}
struct EqualSign: StaticTextDocument {
    static var textBody: some TextDocument { " = " }
}
typealias Assignment<Var, Value> = _KeyValue<Var, EqualSign, Value> where Var: TextDocument, Value: TextDocument
extension _KeyValue where Sign: StaticTextDocument {
    init(_ key: String, value: Value) where Key == String {
        self.key = key
        self.sign = Sign()
        self.value = value
    }
    init(_ key: String, @TextDocumentBuilder value: () -> Value) where Key == String {
        self.key = key
        self.sign = Sign()
        self.value = value()
    }
    init(_ key: String, value: String) where Key == String, Value == String {
        self.key = key
        self.sign = Sign()
        self.value = value
    }
}

///

struct SideConstraints: TextDocument {
    let varName: String
    let container: String
    let constants: EdgeInsets
    var textBody: some TextDocument {
        """
        NSLayoutConstraint.activate([
            \(varName).topAnchor.constraint(equalTo: \(container).topAnchor, constant: \(constants.top)),
            \(varName).bottomAnchor.constraint(equalTo: \(container).bottomAnchor, constant: \(constants.bottom)),
            \(varName).leadingAnchor.constraint(equalTo: \(container).leadingAnchor, constant: \(constants.left)),
            \(varName).trailingAnchor.constraint(equalTo: \(container).trailingAnchor, constant: \(constants.right))
        ])
        """
    }
}
struct RectConstraints: TextDocument {
    let varName: String
    let container: String
    let rect: CGRect
    let setHeight: Bool
    var textBody: some TextDocument {
        """
        NSLayoutConstraint.activate([
            \(varName).topAnchor.constraint(equalTo: \(container).topAnchor, constant: \(rect.minY)),
            \(varName).leadingAnchor.constraint(equalTo: \(container).leadingAnchor, constant: \(rect.minX)),
            \(varName).widthAnchor.constraint(equalToConstant: \(rect.width))\(height)
        ])
        """
    }
    @TextDocumentBuilder var height: some TextDocument {
        if setHeight {
            "\(varName).heightAnchor.constraint(equalToConstant: \(rect.height))".indent(4).prefix(",\n")
        }
    }
}
struct LazyProperty<Init, Body>: TextDocument where Init: TextDocument, Body: TextDocument {
    let name: String
    let type: String
    let container: String?
    @TextDocumentBuilder let initializer: Init
    @TextDocumentBuilder let body: (String) -> Body
    var textBody: some TextDocument {
        CodeBlock {
            "lazy var \(name): \(type) = \(initializer)"
            if let container = container {
                ".add(to: \(container))"
            } else {
                ".let"
            }
        } args: { "arg in" } body: {
            body("arg")
        }
    }
}
struct LazyLabel<TextColor>: TextDocument where TextColor: TextDocument {
    let name: String
    let text: String?
    let fontFamily: String
    let fontSize: Double
    let fontWeight: String
    let container: String?
    let rects: (frame: CGRect, bounds: CGRect)
    @TextDocumentBuilder let textColor: (String) -> TextColor
    var textBody: some TextDocument {
        LazyProperty(name: name, type: "UILabel", container: container, initializer: { "UILabel(autolayout: true)" }) { varName in
            LabelConfig(varName: varName, text: text, fontFamily: fontFamily, fontSize: fontSize, fontWeight: fontWeight, textColor: textColor)
            if let container = container {
                RectConstraints(varName: varName, container: container, rect: rects.frame.inside(rects.bounds), setHeight: false).prefix("\n")
            }
        }
    }
}
struct LabelConfig<TextColor>: TextDocument where TextColor: TextDocument {
    let varName: String
    let text: String?
    let fontFamily: String
    let fontSize: Double
    let fontWeight: String
    @TextDocumentBuilder let textColor: (String) -> TextColor
    var textBody: some TextDocument {
        text.prefix("\"").suffix("\"").prefix("\(varName).text = ").suffix("\n")
        textColor("\(varName).textColor").suffix("\n")
        """
        \(varName).font = UIFont.systemFont(ofSize: \(fontSize), weight: .\(fontWeight)) //UIFont.\(fontFamily).\(fontWeight)(\(fontSize))
        \(varName).numberOfLines = 0
        """
    }
}
struct LazyView: TextDocument {
    let name: String
    let type: String
    let cornerRadius: Double?
    let container: String?
    let rects: (frame: CGRect, bounds: CGRect)
    var textBody: some TextDocument {
        LazyProperty(name: name, type: type, container: container, initializer: { "\(type)(autolayout: true)" }) { varName in
            if let cornerRadius = cornerRadius {
                """
                \(varName).layer.cornerRadius = \(cornerRadius)
                \(varName).clipsToBounds = true
                """
            }
            if let container = container {
                cornerRadius.map({ _ in "\n" })
                RectConstraints(varName: varName, container: container, rect: rects.frame.inside(rects.bounds), setHeight: true)
            }
        }
    }
}

///
import FigmaKit

extension Color: TextDocument {
    public var textBody: some TextDocument {
        "UIColor(red: \(r), green: \(g), blue: \(b), alpha: \(a))"
    }
}
struct GradientedColor<Assingment>: TextDocument where Assingment: TextDocument {
    let gradient: Gradient
    let size: CGFloat
    @TextDocumentBuilder let assignment: (String) -> Assingment
    var textBody: some TextDocument {
        """
        let colors = [\(colors)]
        let gradient = UIImage.gradiented(colors, size: \(size), horizontal: true)
        """
        assignment("UIColor(patternImage: gradient)").prefix("\n")
    }
    @TextDocumentBuilder var colors: some TextDocument {
        ForEach(gradient.gradientStops, separator: ",") { stop in
            "\(stop.color).cgColor"
        }
    }
}
struct ViewBackground: TextDocument {
    let varName: String?
    let node: Node.VectorNode
    var textBody: some TextDocument {
        ForEach(node.fills.lazy.filter(\.visible), separator: "\n") { fill in
            switch fill.type {
            case .image: image((fill as! Image).ref ?? "")
            case .solid: solid((fill as! Paint.Solid).color, wrapped: node.fills.count > 1)
            case .linearGradient, .radialGradient, .angularGradient: Gradient(gradient: fill as! FigmaKit.Gradient, varName: varName)
            default: NullDocument()
            }
        }
    }

    @TextDocumentBuilder func solid(_ color: Color, wrapped: Bool) -> some TextDocument {
        if wrapped {
            "\(varName.suffix("."))addSubview(UIView(background: \(color)))"
        } else {
            "\(varName.suffix("."))backgroundColor = \(color)"
        }
    }
    @TextDocumentBuilder func image(_ ref: String) -> some TextDocument {
        """
        let bimg = UIImageView(image: UIImage(named: "\(ref)"))
        bimg.frame = \(varName.suffix("."))frame
        \(varName.suffix("."))addSubview(bimg)
        """
    }
    struct Gradient: TextDocument {
        let gradient: FigmaKit.Gradient
        let varName: String?
        var textBody: some TextDocument {
        """
        let glr = CAGradientLayer()
        glr.type = \(type)
        glr.colors = [\(colors)]
        glr.locations = [\(locations)]
        glr.startPoint = CGPoint(x: \(start.x), y: \(start.y))
        glr.endPoint = CGPoint(x: \(end.x), y: \(end.y))
        glr.frame = \(varName.suffix("."))frame
        \(varName.suffix("."))layer.addSublayer(glr)
        """
        }
        var type: String {
            switch gradient.type {
            case .radialGradient: return ".radial"
            case .angularGradient: return ".conic"
            default: return ".axial"
            }
        }
        var start: Vector {
            gradient.gradientHandlePositions[0]
        }
        var end: Vector {
            gradient.gradientHandlePositions[1]
        }
        var locations: some TextDocument {
            ForEach(gradient.gradientStops, separator: ",") { el in
                "\(el.position)"
            }
        }
        var colors: some TextDocument {
            ForEach(gradient.gradientStops, separator: ",") { el in
                "\(el.color).cgColor"
            }
        }
    }
}

struct TextNodeProp: TextDocument {
    let name: String
    let parent: Node.VectorNode
    let node: Node.TextNode
    let container: String?
    var textBody: some TextDocument {
        LazyLabel(name: _name, text: text, fontFamily: node.style.fontFamily, fontSize: node.style.fontSize, fontWeight: node.style.fontWeightName, container: container, rects: (node.absoluteBoundingBox.cgRect, parent.absoluteBoundingBox.cgRect)) { argName in
            if let paint = node.fills.first {
                switch paint.type {
                case .solid: Assignment(argName, value: (paint as! Paint.Solid).color)
                case .linearGradient:
                    GradientedColor(gradient: paint as! Gradient, size: node.absoluteBoundingBox.width) { value in
                        Assignment(argName, value: value)
                    }
                default: NullDocument()
                }
            }
        }
    }
    var _name: String { "\(name.variableName)Label" }
    var text: String? { node.characters.components(separatedBy: .newlines).joined(separator: "\\n") }
    var insets: EdgeInsets { node.absoluteBoundingBox.cgRect.edgeInsets(from: parent.absoluteBoundingBox.cgRect) }
}
struct VectorNodeProp: TextDocument {
    let parent: Node.VectorNode
    let subview: SubviewModel
    let container: String?
    var textBody: some TextDocument {
        LazyView(name: "\(subview.name.variableName)View", type: "\(subview.name.typeName)View", cornerRadius: cornerRadius, container: container, rects: (subview.node.absoluteBoundingBox.cgRect, parent.absoluteBoundingBox.cgRect))
    }
    var cornerRadius: Double? {
        (subview.node as? RoundedCorners).flatMap({ n in
            guard let radius = n.cornerRadius else {
                guard let radii = n.rectangleCornerRadii else { return nil }
                guard radii.allEqual else { return nil } // TODO:
                return radii.topRight
            }
            return radius
        })
    }
    var insets: EdgeInsets { subview.node.absoluteBoundingBox.cgRect.edgeInsets(from: parent.absoluteBoundingBox.cgRect) }
}

struct Function<Args, Body>: TextDocument where Args: TextDocument, Body: TextDocument {
    let name: String
    let modifiers: String?
    let resultType: String?
    @TextDocumentBuilder let args: Args
    @TextDocumentBuilder let body: Body
    var textBody: some TextDocument {
        CodeBlock { "\(modifiers.suffix(" "))func \(name)(\(args))\(resultType.prefix(" -> "))" } args: {} body: {
            body
        }
    }
}

struct Subview: TextDocument {
    let subview: SubviewModel
    var textBody: some TextDocument {
        Class(name: "\(subview.name.typeName)View") { "UIView" } properties: {
            ForEach(subview.subviews, separator: "\n") { child in
                switch child.node.type {
                case .vector, .frame, .instance, .rectangle, .group:
                    VectorNodeProp(parent: subview.node, subview: child, container: "self")
                case .text:
                    TextNodeProp(name: child.name, parent: subview.node, node: child.node as! Node.TextNode, container: "self")
                default: NullDocument()
                }
            }
        } functions: {
            if subview.node.fills.contains(where: \.visible) || subview.subviews.count > 0 {
                CodeBlock { "override init(frame: CGRect)" } args: {} body: {
                    "super.init(frame: frame)"
                    ViewBackground(varName: nil, node: subview.node)
                        .modifiable(whenContent: { $0.count > 0 })
                        .prefix("\n")
                    ForEach(subview.subviews, separator: "\n") { child in
                        Assignment("_", value: child.variableName)
                    }
                    .modifiable(whenContent: { $0.count > 0 })
                    .prefix("\n")
                }
                CodeBlock { "required init?(coder: NSCoder)" } args: {} body: {
                    "fatalError(\"init(coder:) has not been implemented\")"
                }.prefix("\n")
            }
        }
    }
}
struct Extensions: TextDocument {
    let subview: SubviewModel
    var textBody: some TextDocument {
        CodeBlock { "\(Keyword.extension) \(subview.namePath.joined(separator: "."))" } args: {} body: {
            ForEach(subview.subviews.lazy.filter({ $0.node.type != .text }), separator: "\n", content: { child in
                Subview(subview: child)
            })
        }
        ForEach(subview.subviews.lazy.filter({ $0.subviews.count > 0 }), separator: "\n") { child in
            if child.node.type != .text {
                Extensions(subview: child)
            }
        }.prefix("\n")
    }
}

///

final class DocumentViewModel {
    let node: Node
    let subview: SubviewModel
    init(_ node: Node) {
        self.node = node
        let namePath = ["\(node.name.typeName)ViewController"]
        self.subview = SubviewModel(name: node.name, node: node as! Node.VectorNode, namePath: namePath, subviews: node.generateSubviews(namePath))
    }
}
extension DocumentViewModel {
    static let root: DocumentViewModel = {
        let decoder = JSONDecoder()
        let url = Bundle.module.url(forResource: "figma_response", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let file = try! decoder.decode(File.self, from: data)
        let node = file.document.node(at: ["105:811", "114:369"])!
        return DocumentViewModel(node)
    }()

    func name(for node: Node, parent: Node) -> String {
        let index = parent.children.reduce(into: 0, while: { $0 != node }, { $0 += $1.name == node.name ? 1 : 0 })
        return node.name + (index > 0 ? "\(index)" : "")
    }
}
extension TextDocument {
    var model: DocumentViewModel { .root }
}

struct Code: TextDocument {
    var name: String { "\(model.node.name.typeName)ViewController" }
    var textBody: some TextDocument {
        Class(name: name) { "UIViewController" } properties: {
            ForEach(model.subview.subviews, separator: "\n") { child in
                switch child.node.type {
                case .vector, .frame, .instance, .rectangle, .group:
                    VectorNodeProp(parent: model.node as! Node.VectorNode, subview: child, container: "view")
                case .text:
                    TextNodeProp(name: child.name, parent: model.node as! Node.VectorNode, node: child.node as! Node.TextNode, container: "view")
                default: NullDocument()
                }
            }
        } functions: {
            if model.subview.node.fills.contains(where: \.visible) {
                Function(name: "viewDidLoad", modifiers: "override", resultType: nil, args: {}) {
                    "super.viewDidLoad()"
                    ViewBackground(varName: "view", node: model.subview.node)
                        .modifiable(whenContent: { $0.count > 0 })
                        .prefix("\n")
                    ForEach(model.subview.subviews, separator: "\n") { child in
                        Assignment("_", value: child.variableName)
                    }
                    .modifiable(whenContent: { $0.count > 0 })
                    .prefix("\n")
                }
            }
        }
        Extensions(subview: model.subview).prefix("\n")
    }
}
struct TestCode: TextDocument {
    var textBody: some TextDocument {
        Tag(.head) {
            """
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.5.1/styles/default.min.css">
            <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.5.1/highlight.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.5.1/languages/swift.min.js"></script>
            <script>hljs.highlightAll();</script>
            """
        }
        Tag(.h1) { "Code generation with DocumentUI" }
        Tag(.div) {
            Attribute(.style) {
                KeyValue(.max_height, value: "50%")
                KeyValue(.overflow, value: "auto").prefix(";")
            }
        } content: {
            Tag(.pre) {
                Tag(.code) {
                    Attribute(.class, value: "language-swift")
                } content: {
                    Code()
                }
            }
        }
        Tag(.pre) {
            Attribute(.style, value: "background-color: #eee;padding:10px")
        } content: {
            Code()
        }
    }
}
