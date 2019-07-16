//
//  Logger.swift
//  2019_DEV_175
//

import Foundation
/// Logger give access to more advanced and clearer print()
final class Logger {

    private init() {
    }

    /// Basic logger to print message
    public static func log(_ message: String?, file: String = #file, line: Int = #line) {
        #if DEBUG
        print("⚠️ \(self.getTime()) \(self.formatPath(path: file)) - l:\(line) - \((message ?? "")!) ⚠️")
        #endif
    }

    /// Basic logger to print object with message
    public static func log(_ message: String = "", file: String = #file, line: Int = #line, object: Any) {
        #if DEBUG
        print("⚠️ \(self.getTime()) \(self.formatPath(path: file)) - l:\(line) - \(message) - \(object) ⚠️")
        #endif
    }

    // MARK: - Error
    /// Error logger to print error with message
    public static func error(_ message: String?, file: String = #file, line: Int = #line, function: String = #function) {
        #if DEBUG
        print("❌ \(self.getTime()) \(self.formatPath(path: file)) - l:\(line): \(function) - Error: \((message ?? "")!) ❌")
        #endif
    }

    /// Error logger for print error with object and message
    public static func error(_ message: String = "Error", file: String = #file, line: Int = #line, function: String = #function, object: Any) {
        #if DEBUG
        print("❌ \(self.getTime()) \(self.formatPath(path: file)) - l:\(line): \(function) - Success: \(message) "+" \(object) ❌")
        #endif
    }

    // MARK: - Success
    /// Success logger to print success with message
    public static func success(_ message: String?, file: String = #file, line: Int = #line, function: String = #function) {
        #if DEBUG
        print("✅ \(self.getTime()) \(self.formatPath(path: file)) - l:\(line): \(function) - \((message ?? "")!) ✅")
        #endif
    }

    /// Success logger to print success with object and message
    public static func success(_ message: String = "Success", file: String = #file, line: Int = #line, function: String = #function, object: Any) {
        #if DEBUG
        print("✅ \(self.getTime()) \(self.formatPath(path: file)) - l:\(line): \(function) - \(message) "+" \(object) ✅")
        #endif
    }

    private static func getTime() -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .medium
        return timeFormatter.string(from: Date())
    }

    private static func formatPath(path: String) -> String {
        var paths = path.components(separatedBy: "/")
        paths.removeFirst(paths.count-3 >= 3 ? paths.count-3 : paths.count-2)
        var string = ""
        for str in paths {
            string.append(str+"/")
        }
        string.removeLast()
        return string
    }
}
