//
//  AppSettings.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation

struct AppSettings {
    let environment: String
    let baseUrl: String
    
    init() {
        let settings = AppSettings.retrieveSettingsFromFile()
        
        #if DEBUG
            environment = "development"
            baseUrl = (settings["baseUrl"] as! [String:String])["dev"]!
        #else
            environment = "production"
            baseUrl = (settings["baseUrl"] as! [String:String])["prod"]!
        #endif
    }
    
    private static func retrieveSettingsFromFile() -> [String: Any] {
        let filePath = Bundle.main.path(forResource: "AppSettings", ofType: "plist")
        let settings = NSDictionary(contentsOfFile: filePath!)
        
        return settings as! [String : Any]
    }
}
