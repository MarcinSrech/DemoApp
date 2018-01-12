//
//  HTMLParser.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation
import Fuzi

class HTMLParser {
    static func parseProfiles(_ html: String) -> [[String: Any]] {
        var profiles = [[String: Any]]()
        
        do {
            let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
            let categorySection = doc.css("#categoryPage")
            if let element = categorySection.first {
                let results = element.css(".profileMain").filter({ $0.attr("class") ?? "" == "profileMain inactive " })
                
                results.forEach {
                    var profile = [String: Any]()
                    if let profileTitle = $0.css(".profileMainTitle").first {
                        profile["title"] = profileTitle.stringValue
                        if let link = profileTitle.firstChild(css: "a, link") {
                            profile["link"] = link["href"]
                        }
                    }
                    
                    if let profileNick = $0.css(".profileMainNick").first {
                        profile["teacherNick"] = profileNick.stringValue
                    }
                    
                    if profile.count > 0 {
                        profiles.append(profile)
                    }
                }
            }
        } catch let error {
            print(error)
        }
        

        return profiles
    }
}
