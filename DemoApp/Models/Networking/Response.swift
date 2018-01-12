//
//  Response.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation

import SwiftyJSON

enum Response {
    case json(_: JSON)
    case data(_: Data)
    case error(_: Int?, _: Error?)
    
    init(_ response: (r: HTTPURLResponse?, data: Data?, error: Error?), for request: Request) {
        guard response.r?.statusCode == 200 || response.r?.statusCode == 201 ||
            response.r?.statusCode == 204, response.error == nil else {
                self = .error(response.r?.statusCode, response.error)
                return
        }
        
        guard let data = response.data else {
            self = .error(response.r?.statusCode, NetworkErrors.noData)
            return
        }
        
        switch request.dataType {
        case .DATA:
            self = .data(data)
        case .JSON:
            do {
                let json = try JSON(data: data)
                self = .json(json)
            } catch {
                self = .error(response.r?.statusCode, NetworkErrors.noData)
            }
        }
    }
}
