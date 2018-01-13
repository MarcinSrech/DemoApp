//
//  DataProvider.swift
//  DemoApp
//
//  Created by Marcin Srech on 13.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

protocol DataProvider {
    
    func fetchObservableData() -> Observable<[NSManagedObject]>
    func loadAllObjects()
    func findObjects(by key: String, value: String)
    func findObjects(by predicate: NSPredicate)
}
