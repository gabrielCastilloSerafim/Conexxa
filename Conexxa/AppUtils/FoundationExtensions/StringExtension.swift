//
//  StringExtension.swift
//  Conexxa
//
//  Created by Gabriel Castillo Serafim on 13/9/23.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func localized(_ args: [CVarArg]) -> String {
        return String(format: localized, args)
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localized, args)
    }
}
