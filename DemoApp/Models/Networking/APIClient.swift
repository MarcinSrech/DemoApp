//
//  APIClient.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation
import Hydra
import MagicalRecord


class APIClient {
    //MARK: - Properties
    let environment: Environment
    let dispatcher: NetworkDispatcher
    var context = NSManagedObjectContext.mr_default()
    
    
    
    //MARK: - Singleton
    static let shared = APIClient()
    private init() {
        let headers = ["Content-Type": "text/html"]
        environment = Environment(name: "Dev", host: "https://buddyschool.com/", headers: headers, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        dispatcher = NetworkDispatcher(environment: environment)
        context.automaticallyMergesChangesFromParent = true
    }
    
    
    //MARK: - Profiles
    func findProducts(by keywords: String) -> Promise<Void> {
        return Promise<Void>(in: .background, { resolve, reject, _ in
            let findOperation = FindProfilesOperation<Data>(keywords: keywords)
            findOperation.execute(in: self.dispatcher).then({ [unowned self] (profiles) in
                if let html = String(data: profiles, encoding: String.Encoding.utf8) {
                    let profiles = HTMLParser.parseProfiles(html)
                    if profiles.count > 0 {
                        let newContext = NSManagedObjectContext.mr_context(withParent: self.context)
                        CDProfile.mr_truncateAll(in: newContext)
                        _ = CDProfile.mr_import(from: profiles as [[AnyHashable: Any]], in: newContext) as? [CDProfile]
                        newContext.mr_saveToPersistentStoreAndWait()
                    }
                }
                
                resolve(Void())
            }).catch({ (error) in
                reject(error)
            }) 
        })
    }

    
}
