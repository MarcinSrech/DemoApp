//
//  APIClient.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation

class APIClient {
    //MARK: - Properties
    let environment: Environment
    let dispatcher: NetworkDispatcher
    
    
    //MARK: - Singleton
    static let shared = APIClient()
    private init() {
        let headers = ["Content-Type": "application/json"]
        environment = Environment(name: "Dev", host: "", headers: headers, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        dispatcher = NetworkDispatcher(environment: environment)
    }
    
    
    //MARK: - Profiles
    
    
}
