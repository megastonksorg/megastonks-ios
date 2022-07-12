//
//  String+Extension.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2022-07-11.
//

import SwiftUI

extension String {
    var isReal: Bool {
        if self.isEmpty { return false }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: self.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: self, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
}
