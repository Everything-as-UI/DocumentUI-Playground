//
//  Created by Denis Koryttsev on 22.06.2022.
//

import Foundation
import FileWatcher

let args = ProcessInfo.processInfo.arguments
guard args.count > 1 else { exit(1) }

let filePath = NSString(string: args[1]).expandingTildeInPath

let fileName = String(filePath.split(separator: "/").last!)
let filewatcher = FileWatcher([filePath])
filewatcher.callback = { (event: FileWatcherEvent) in
    guard event.fileChange else { return }
    let result = ScriptWizard.run(script: .reload(.chrome(fileName)))
    print(result as Any)
}
filewatcher.start()

RunLoop.main.run()
