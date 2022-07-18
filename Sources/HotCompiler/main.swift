//
//  Created by Denis Koryttsev on 22.06.2022.
//

import DocumentUI
import FileWatcher
import Foundation

let args = ProcessInfo.processInfo.arguments
let filePath = NSString(string: args[1]).expandingTildeInPath
let previewFilePath = NSString(string: args[2]).expandingTildeInPath
print(filePath, previewFilePath)
guard FileManager.default.fileExists(atPath: filePath) else { exit(1) }
let fileName = String(filePath.split(separator: "/").last!)
let filewatcher = FileWatcher([filePath])
var lastUpdate = ProcessInfo.processInfo.systemUptime
filewatcher.callback = { (event: FileWatcherEvent) in
    guard event.fileChange else { return }
    let throttle = ProcessInfo.processInfo.systemUptime - lastUpdate
    guard throttle >= 1.0 else { return }
    lastUpdate = ProcessInfo.processInfo.systemUptime
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/usr/bin/swift")
    task.arguments = ["run", "DocumentGenerator", previewFilePath]
    print(task)
    do {
        try task.run()
    } catch {
        print("Error:", String(describing: error))
    }
}
filewatcher.start()

RunLoop.main.run()
