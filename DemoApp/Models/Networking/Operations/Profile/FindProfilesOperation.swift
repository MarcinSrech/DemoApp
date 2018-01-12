//
//  FindProfilesOperation.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation
import Hydra

class FindProfilesOperation<JSON>: Operation {
    
    var keywords: String
    
    init(keywords: String) {
        self.keywords = keywords
    }
    
    var request: Request {
        return ProfileRequests.findProfiles(by: self.keywords)
    }
    
    func execute(in dispatcher: Dispatcher) -> Promise<Data> {
        return Promise<Data>({ resolve, reject, _ in
            do {
                try dispatcher.execute(request: self.request).then({ response in
                    switch response {
                    case .json(_):
                        break
                    case .data(let data):
                        resolve(data)
                    case .error( _, let error):
                        reject(error!)
                    }
                    
                }).catch(reject)
            } catch {
                reject(error)
            }
        })
    }
}
