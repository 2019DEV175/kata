//
//  DefaultManager.swift
//  2019_DEV_175
//

import Foundation

final class DefaultManager {

    private enum Key: String {
        case language
    }

    // MARK: - language
    static var language: String {
        get {
            guard let lang = UserDefaults.standard.value(forKey: Key.language.rawValue) as? String else {
                return Locale.current.languageCode ?? "en"
            }
            return lang
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.language.rawValue)
        }
    }
}
