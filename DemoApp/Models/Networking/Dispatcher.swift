//
//  Dispatcher.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation
import Hydra

protocol Dispatcher {
    
    init(environment: Environment)
    
    func execute(request: Request) throws -> Promise<Response>
}
