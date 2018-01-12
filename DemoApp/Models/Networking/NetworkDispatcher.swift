//
//  NetworkDispatcher.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation
import Hydra
import Alamofire

enum NetworkErrors: Error {
    case badInput
    case noData
}

class NetworkDispatcher: Dispatcher {
    
    private var environment: Environment
    private var session: URLSession
    
    required init(environment: Environment) {
        self.environment = environment
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func execute(request: Request) throws -> Promise<Response> {
        let rq = try self.prepareURLRequest(for: request)
        return Promise<Response>(in: .background, { resolve, _, _ in
            Alamofire.request(rq).response { (responseFromApi) in
                let response = Response( (responseFromApi.response,responseFromApi.data,responseFromApi.error), for: request)
                resolve(response)
            }
        })
    }
    
    private func prepareURLRequest(for request: Request) throws -> URLRequest {
        let fullURL = "\(environment.host)\(request.path)"
        let urlRequest = NSMutableURLRequest(url: URL(string: fullURL)!)
        
        switch request.parameters {
        case .body(let params):
            if let params = params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .init(rawValue: 0))
            } else {
                throw NetworkErrors.badInput
            }
        case .url(let params):
            if let params = params as? [String: String] {
                let queryParams = params.map({ (element) -> URLQueryItem in
                    return URLQueryItem(name: element.key, value: element.value)
                })
                
                guard var components = URLComponents(string: fullURL) else {
                    throw NetworkErrors.badInput
                }
                components.queryItems = queryParams
                urlRequest.url = components.url
            } else {
                throw NetworkErrors.badInput
            }
        }
        
        environment.headers.forEach({ urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) })
        request.headers?.forEach({ urlRequest.setValue($0.value as? String, forHTTPHeaderField: $0.key) })
        
        urlRequest.httpMethod = request.method.rawValue
        
        return urlRequest as URLRequest
    }
    
}
