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
            let keyword = doc.css("#keyword").first?.attr("value") ?? ""
            let categorySection = doc.css("#categoryPage")
            if let element = categorySection.first {
                let results = element.css(".profileMain").filter({ $0.attr("class") ?? "" == "profileMain inactive " })
                
                results.forEach {
                    guard let profileTitle = $0.css(".profileMainTitle").first,
                        let link = profileTitle.firstChild(css: "a, link"),
                        let profileNick = $0.css(".profileMainNick").first else {
                            return
                    }
                    
                    var profile = [String: Any]()
                    profile["title"] = profileTitle.stringValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    profile["link"] = link["href"]
                    profile["teacherNick"] = profileNick.stringValue.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    profile["keyword"] = keyword
                    profiles.append(profile)
                }
            }
        } catch let error {
            print(error)
        }
        
        return profiles
    }
}
