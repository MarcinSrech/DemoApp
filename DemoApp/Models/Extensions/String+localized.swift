//
//  String+localized.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation

extension String {
    static func localized(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
