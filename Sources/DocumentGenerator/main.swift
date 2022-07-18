//
//  Created by Denis Koryttsev on 22.06.2022.
//

import Foundation

let args = ProcessInfo.processInfo.arguments
let url = URL(fileURLWithPath: NSString(string: args[1]).expandingTildeInPath)
if true {
    let document = TestCode()
    try "\(document)".write(to: url, atomically: false, encoding: .utf8)
} else {
    let document = TestSite()
    try "\(document)".write(to: url, atomically: false, encoding: .utf8)
}
