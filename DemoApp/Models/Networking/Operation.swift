//
//  Operation.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation
import Hydra

protocol Operation {
    associatedtype Output
    
    var request: Request {get}
    
    func execute(in dispatcher: Dispatcher) -> Promise<Output>
}
