//
//  String+Convenients.swift
//  2019_DEV_175
//

import Foundation
/// String+convenients contains all the convenients tools we use in String
extension String {

    var localized: String {
        let lang = DefaultManager.language
        let path = Bundle.main.path(forResource: (Constants.Language.available.contains(lang) ? lang : "en"), ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
