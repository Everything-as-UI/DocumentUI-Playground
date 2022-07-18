//
//  Created by Denis Koryttsev on 24.06.2022.
//

import DocumentUI

extension HTML.Tag: TextDocument {
    var textBody: some TextDocument { rawValue }
}
extension HTML.Attribute: TextDocument {
    var textBody: some TextDocument { rawValue }
}
extension HTML.CSSProperty: TextDocument {
    var textBody: some TextDocument { rawValue }
}

struct Tag<Content, Attributes>: TextDocument where Content: TextDocument, Attributes: TextDocument {
    let name: String
    @TextDocumentBuilder let attributes: Attributes
    @TextDocumentBuilder let content: Content
    init(_ name: String, @TextDocumentBuilder attributes: () -> Attributes, @TextDocumentBuilder content: () -> Content) {
        self.name = name
        self.attributes = attributes()
        self.content = content()
    }
    init(_ name: String, @TextDocumentBuilder content: () -> Content) where Attributes == NullDocument {
        self.name = name
        self.attributes = NullDocument()
        self.content = content()
    }
    var textBody: some TextDocument {
        "<\(name)\(attributes.prefix(" "))>\(content)</\(name)>"
    }
}
extension Tag {
    init(_ tag: HTML.Tag, @TextDocumentBuilder attributes: () -> Attributes, @TextDocumentBuilder content: () -> Content) {
        self.init(tag.rawValue, attributes: attributes, content: content)
    }
    init(_ tag: HTML.Tag, @TextDocumentBuilder content: () -> Content) where Attributes == NullDocument {
        self.init(tag.rawValue, content: content)
    }
}
struct Attribute<Key, Value>: TextDocument where Key: TextDocument, Value: TextDocument {
    @TextDocumentBuilder let key: Key
    @TextDocumentBuilder let value: Value
    var textBody: some TextDocument {
        "\(key)=\"\(value)\""
    }
}
extension Attribute {
    init(_ key: String, @TextDocumentBuilder value: () -> Value) where Key == String {
        self.key = key
        self.value = value()
    }
    init(_ key: String, value: String) where Key == String, Value == String {
        self.key = key
        self.value = value
    }
    init(_ attr: HTML.Attribute, @TextDocumentBuilder value: () -> Value) where Key == HTML.Attribute {
        self.key = attr
        self.value = value()
    }
    init(_ attr: HTML.Attribute, value: String) where Key == HTML.Attribute, Value == String {
        self.key = attr
        self.value = value
    }
}
struct KeyValue<Key, Value>: TextDocument where Key: TextDocument, Value: TextDocument {
    @TextDocumentBuilder let key: Key
    @TextDocumentBuilder let value: Value
    var textBody: some TextDocument {
        "\(key):\(value)"
    }
}
extension KeyValue {
    init(_ key: String, @TextDocumentBuilder value: () -> Value) where Key == String {
        self.key = key
        self.value = value()
    }
    init(_ key: String, value: String) where Key == String, Value == String {
        self.key = key
        self.value = value
    }
    init(_ prop: HTML.CSSProperty, @TextDocumentBuilder value: () -> Value) where Key == HTML.CSSProperty {
        self.key = prop
        self.value = value()
    }
    init(_ prop: HTML.CSSProperty, value: String) where Key == HTML.CSSProperty, Value == String {
        self.key = prop
        self.value = value
    }
}
struct Style<Definition, Properties>: TextDocument where Definition: TextDocument, Properties: TextDocument {
    @TextDocumentBuilder let definition: Definition
    @TextDocumentBuilder let properties: Properties
    var textBody: some TextDocument {
        "\(definition){\(properties)}"
    }
}
extension Style {
    init(_ definition: String, @TextDocumentBuilder properties: () -> Properties) where Definition == String {
        self.definition = definition
        self.properties = properties()
    }
    init(tag: HTML.Tag, @TextDocumentBuilder properties: () -> Properties) where Definition == HTML.Tag {
        self.definition = tag
        self.properties = properties()
    }
}
