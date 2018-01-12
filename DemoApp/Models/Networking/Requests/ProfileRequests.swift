//
//  ProfileRequests.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation

enum ProfileRequests: Request {
    case findProfiles(by: String)
    
    var path: String {
        switch self {
        case .findProfiles(_):
            return "search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .findProfiles(_):
            return .GET
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .findProfiles(let keywords):
            return .url(["keyword": keywords])
        }
    }
    
    var headers: [String : Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var dataType: DataType
    {
        switch self {
        case .findProfiles(_):
            return .DATA
        }
    }
    
}
