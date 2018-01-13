//
//  CDProfilesDataProvider.swift
//  DemoApp
//
//  Created by Marcin Srech on 13.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation
import RxSwift
import MagicalRecord

class CDProfileDataProvider: DataProvider {
    
    //MARK: - Properties
    
    private var profilesFromCoreData = Variable<[NSManagedObject]>([])
    
    //MARK: - Methods
    
    init() {
        profilesFromCoreData.value = [NSManagedObject]()
    }
    
    func fetchObservableData() -> Observable<[NSManagedObject]> {
        return profilesFromCoreData.asObservable()
    }
    
    func loadAllObjects() {
        profilesFromCoreData.value = getAllProfiles()
    }
    
    private func getAllProfiles() -> [NSManagedObject] {
        return CDProfile.mr_findAll() ?? []
    }
    
    func findObjects(by key: String, value: String) {
        if value == "" {
            profilesFromCoreData.value = []
        } else {
            profilesFromCoreData.value = CDProfile.mr_find(byAttribute: key, withValue: value) ?? []
        }
    }
    
    func findObjects(by predicate: NSPredicate) {
        profilesFromCoreData.value = CDProfile.mr_findAll(with: predicate) ?? []
    }
    
    
}

