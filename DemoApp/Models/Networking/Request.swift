//
//  Request.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation

enum DataType {
    case JSON
    case DATA
}

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}

enum RequestParams {
    case url(_: [String: Any]?)
    case body(_: [String: Any]?)
}

protocol Request {
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: RequestParams {get}
    var headers: [String: Any]? {get}
    var dataType: DataType {get}
}
