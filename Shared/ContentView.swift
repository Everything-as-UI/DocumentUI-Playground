import SwiftUI
import AttributedTextUI

#if os(macOS)
typealias _Font = NSFont
typealias _Image = NSImage
typealias _Color = NSColor
extension NSImage {
    convenience init?(systemName: String) {
        self.init(systemSymbolName: systemName, accessibilityDescription: nil)
    }
}
extension NSColor {
    static var label: NSColor { labelColor }
    static var separator: NSColor { separatorColor }
    static var secondaryLabel: NSColor { secondaryLabelColor }
}
typealias _ViewRepresentable = NSViewRepresentable
#else
typealias _Font = UIFont
typealias _Image = UIImage
typealias _Color = UIColor
typealias _ViewRepresentable = UIViewRepresentable
#endif

extension Text {
    @available(iOS 15.0, macOS 12, *)
    init<Content>(@AttributedTextBuilder content: () -> Content) where Content: AttributedText {
        var interpolator = Content.AttributedTextInterpolation(content())
        self.init(interpolator.build().attributedString())
    }
}

struct ContentView: View {
    @State var useNativeText: Bool = false
    var body: some View {
        VStack {
            if useNativeText {
                Image(systemName: "swift")
                    .symbolRenderingMode(.palette)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                Text { textContent }
                    .multilineTextAlignment(.center)
            } else {
                TextView { textContent }
            }
            Button("Toggle to \(useNativeText ? "NSAttributedString" : "SwiftUI AttributedString")") {
                useNativeText.toggle()
            }
            Text {
                "Click to change renderer"
                    .attribute(.font, value: _Font.preferredFont(forTextStyle: .caption1))
                    .attribute(.foregroundColor, value: _Color.secondaryLabel)
                /*if true { TODO: Requires an equal ModifyContent
                    Paragraph { "Test" }
                } else {
                    "Test"
                }*/
            }
        }
        .frame(minHeight: 600, maxHeight: 1000)
        .padding()
    }

    func consoleOutput<T>(_ text: T) -> String where T: AttributedText {
        var interpolation = T.AttributedTextInterpolation(text)
        let output = interpolation.build().consoleString()
        print(output)
        return output
    }

    @AttributedTextBuilder var consoleContent: some AttributedText {
        Paragraph {
            "Swift".prefix("\n")
                .attributedText()
                .attribute(.font, value: _Font.systemFont(ofSize: 48, weight: .semibold))
                .attribute(.foregroundColor, value: _Color.systemRed)
                .attribute(.underlineStyle, value: NSUnderlineStyle.single)
        }
        Paragraph {
            "The powerful programming language that is also"
            " easy "
                .attribute(.shadow, value: 10)
            "to learn."
        }
        .attribute(.font, value: _Font.systemFont(ofSize: 32, weight: .medium))
        .attribute(.foregroundColor, value: _Color.systemBlue)
        .attribute(.backgroundColor, value: _Color.systemRed)
        Paragraph {
            "Swift is a powerful and intuitive programming language for macOS, iOS, watchOS, tvOS and beyond. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and Swift includes modern features developers love. Swift code is safe by design, yet also produces software that runs lightning-fast."
                .attribute(.foregroundColor, value: _Color.label)
        }
    }

    @AttributedTextBuilder var textContent: some AttributedText {
        Paragraph {
            if let img = _Image(systemName: "swift") {
                img
                #if os(macOS)
                    .withSymbolConfiguration(.init(pointSize: 100, weight: .bold))?
                    .template()
                    .tint(color: .systemRed)
                #else
                    .applyingSymbolConfiguration(.init(pointSize: 100, weight: .bold))?
                    .withRenderingMode(.alwaysTemplate)
                #endif
                    .attribute(.foregroundColor, value: _Color.systemRed) // not working with NSImage
            }
            "Swift".prefix("\n")
                .attributedText()
                .attribute(.font, value: _Font.systemFont(ofSize: 48, weight: .semibold))
                .attribute(.foregroundColor, value: _Color.systemRed)
        }
        .modifier(ParagraphModifier({
            $0.alignment = .center
            $0.paragraphSpacing = 20
        }))
        .attribute(.shadow, value: NSShadow(blurRadius: 8))
        AnyAttributedText(Paragraph {
            AnyAttributedText(
                "The powerful programming language that is also easy to learn."
                    .attribute(.font, value: _Font.systemFont(ofSize: 32, weight: .medium))
                    .attribute(.foregroundColor, value: _Color.systemBlue)
            )
            separator
        }
        .modifier(ParagraphModifier({
            $0.paragraphSpacingBefore = 20
            $0.paragraphSpacing = 20
            $0.alignment = .center
        })))
        Paragraph {
            "Swift is a powerful and intuitive programming language for macOS, iOS, watchOS, tvOS and beyond. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and Swift includes modern features developers love. Swift code is safe by design, yet also produces software that runs lightning-fast."
                .attribute(.font, value: _Font.systemFont(ofSize: 21))
                .attribute(.foregroundColor, value: _Color.label)
        }
        .modifier(ParagraphModifier({
            $0.firstLineHeadIndent = 50
            $0.alignment = .justified
            $0.lineHeightMultiple = 1.2
        }))
        separator
        ForEach(0 ..< 10, separator: " ") { i in
            switch i {
            case ..<5: "\(i)"
            default: NullDocument()
            }
        }
        .prefix("\n")
        .attributedText()
        .attribute(.foregroundColor, value: _Color.red)
    }
    @AttributedTextBuilder var separator: some AttributedText {
        "\u{00A0} \u{0009} \u{00A0}".repeating(10).prefix("\n")
            .attributedText()
            .attribute(.foregroundColor, value: _Color.separator)
            .attribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}

extension Group: View where Content: AttributedText {
    public var body: some View {
        Text(attributedString())
    }

    func attributedString() -> AttributedString {
        var interpolator = Content.AttributedTextInterpolation(body)
        return interpolator.build().attributedString()
    }
}

struct TextView<Content>: _ViewRepresentable where Content: AttributedText {
    @AttributedTextBuilder let content: () -> Content
    init(@AttributedTextBuilder content: @escaping () -> Content)
    { self.content = content }
    #if os(macOS)
    func makeNSView(context: Context) -> NSScrollView {
        let sv = NSTextView.scrollableTextView()
        let tv = (sv.documentView as! NSTextView)
        tv.drawsBackground = false
        return sv
    }
    func updateNSView(_ nsView: NSScrollView, context: Context) {
        let tv = nsView.documentView as! NSTextView
        tv.textStorage?.setAttributedString(attributedString())
    }
    #else
    func makeUIView(context: Context) -> UITextView {
        UITextView()
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = attributedString()
    }
    #endif
    func attributedString() -> NSAttributedString {
        var interpolator = Content.AttributedTextInterpolation(content())
        let string = interpolator.build().nsAttributedString()
        print(string)
        return string
    }
}

#if os(macOS)
extension NSImage {
    func template() -> NSImage {
        isTemplate = true
        return self
    }
}
extension NSImage {
    func tint(color: NSColor) -> NSImage {
        return NSImage(size: size, flipped: false) { (rect) -> Bool in
            color.set()
            rect.fill()
            self.draw(in: rect, from: NSRect(origin: .zero, size: self.size), operation: .destinationIn, fraction: 1.0)
            return true
        }
    }
}
#endif

extension NSShadow {
    convenience init(blurRadius: CGFloat) {
        self.init()
        self.shadowBlurRadius = blurRadius
    }
}
