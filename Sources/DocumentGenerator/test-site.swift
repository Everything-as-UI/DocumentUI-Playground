//
//  Created by Denis Koryttsev on 24.06.2022.
//

import DocumentUI

enum CSSClass: String {
    case header
    case social
}
extension CSSClass: TextDocument {
    var textBody: some TextDocument { rawValue }
    var def: Def { Def(val: self) }
    struct Def: TextDocument {
        let val: CSSClass
        var textBody: some TextDocument { ".\(val)" }
    }
}
extension Attribute {
    init(classes: [CSSClass]) where Key == HTML.Attribute, Value == Joined<String, CSSClass> {
        self.key = .class
        self.value = Joined(separator: " ", elements: classes)
    }
}

struct Head: TextDocument {
    var textBody: some TextDocument {
        Tag(.head) {
            Tag(.link) {
                Attribute(.rel, value: "stylesheet")
                Attribute(.href, value: "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css")
            } content: {}
            Tag(.style) {
                Style { CSSClass.header.def } properties: {
                    Joined(separator: ";") {
                        KeyValue(.display, value: "flex")
                        KeyValue(.justify_content, value: "space-between")
                        KeyValue(.align_items, value: "center")
                        KeyValue(.padding, value: "15px")
                        KeyValue(.background_color, value: "#e9e9e9")
                    }
                }
                Style {
                    Joined(separator: " ") {
                        CSSClass.header.def
                        HTML.Tag.h1
                    }
                } properties: {
                    Joined(separator: ";") {
                        KeyValue(.color, value: "#222222")
                        KeyValue(.font_size, value: "30px")
                        KeyValue(.font_family, value: "\"Pacifico\", cursive")
                    }
                }
                Style {
                    Joined(separator: " ") {
                        CSSClass.header.def
                        CSSClass.social.def
                        HTML.Tag.a
                    }
                } properties: {
                    Joined(separator: ";") {
                        KeyValue(.padding, value: "0 5px")
                        KeyValue(.color, value: "#222222")
                    }
                }
            }
        }
    }
}

struct Header: TextDocument {
    var textBody: some TextDocument {
        Tag(.header) {
            Attribute(classes: [.header])
        } content: {
            Tag(.h1) {
                Attribute(.title, value: "I'm a header")
            } content: {
                "Mr. Bingo"
            }
            Tag(.div) {
                Attribute(classes: [.social])
            } content: {
                ForEach(["facebook", "instagram", "twitter"]) { social in
                    Tag(.a) {
                        Attribute(.href, value: "#")
                    } content: {
                        Tag(.i) {
                            Attribute(.class, value: "fab fa-\(social)")
                        } content: {}
                    }
                }
            }
        }
    }
}

struct Body: TextDocument {
    var textBody: some TextDocument {
        Tag(.body) {
            Header()
            Tag(.p) {
                Joined(separator: " ") {
                    Attribute(.title, value: "I'm a tooltip!")
                    Attribute(.style) {
                        Joined(separator: ";") {
                            KeyValue {
                                "font-size"
                            } value: {
                                "50px"
                            }
                            KeyValue("color", value: "pink")
                            KeyValue("background-color", value: "black")
                        }
                    }
                }
            } content: {
                Tag(.img) {
                    Joined(separator: " ") {
                        Attribute(.src, value: "https://mr.bingo/wp-content/themes/bingo/images/bingo_header.png")
                        Attribute(.style) {
                            Joined(separator: ";") {
                            KeyValue("width", value: "100%")
                                KeyValue("height", value: "300px")
                            }
                        }
                    }
                } content: {}
                Tag(.p) {
                    "Hello, I am here!"
                }
            }
            ForEach(0 ..< 10) { i in
                Tag(.li) {
                    Tag(.a) {
                        Attribute(.href, value: "www.example.com")
                    } content: {
                        "Link \(i)"
                    }
                }
            }
        }
    }
}

struct TestSite: TextDocument {
    var textBody: some TextDocument {
        "<!DOCTYPE html>"
        Tag(.html) {
            Head()
            Body()
        }
    }
}
