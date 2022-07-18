//
//  File.swift
//  
//
//  Created by Denis Koryttsev on 22.06.2022.
//

import Foundation

class ScriptWizard {
    enum Browser {
        case chrome(String)
        case safari
        
        var script: String {
            switch self {
            case .chrome(let file):
                return """
                -- tell application "Google Chrome"
                -- activate
                -- tell application "System Events"
                -- tell process "Google Chrome"
                -- keystroke "r" using {command down, shift down}
                -- end tell
                -- end tell
                -- end tell

                -- Save that in a text file somewhere and run it from terminal with:
                -- osascript name_of_file.applescript

                -- I usually want to refocus Visual Studio Code after reloading Chrome, so I tack
                -- this onto the end of the script:

                -- tell application "Visual Studio Code" to activate

                tell application "Google Chrome" to reload (tabs of window 1 whose URL contains "\(file)")
                    activate
                """
            case .safari:
                return """
                tell application "Safari"
                activate
                tell application "System Events"
                tell process "Safari"
                keystroke "r" using {command down, shift down}
                end tell
                end tell
                end tell

                -- Save that in a text file somewhere and run it from terminal with:
                -- osascript name_of_file.applescript

                -- I usually want to refocus Visual Studio Code after reloading Chrome, so I tack
                -- this onto the end of the script:

                -- tell application "Visual Studio Code" to activate
                """
            }
        }
    }
    
    enum Script {
        case reload(Browser)
        
        func run() -> NSDictionary? {
            switch self {
            case .reload(let browser):
                var error: NSDictionary?
                print(NSAppleScript(source: browser.script)?.executeAndReturnError(&error) as Any)
                return error
            }
        }
    }
    
    static func run(script: Script) -> NSDictionary? {
        script.run()
    }
}
