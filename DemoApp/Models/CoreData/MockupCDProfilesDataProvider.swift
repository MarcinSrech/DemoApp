//
//  MockupCDProfilesDataProvider.swift
//  DemoApp
//
//  Created by Marcin Srech on 16.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation
import RxSwift
import MagicalRecord
import CoreData

class MockupCDProfileDataProvider: DataProvider {
    
    //MARK: - Properties
    
    private var profilesFromCoreData = Variable<[NSManagedObject]>([])
    var context = NSManagedObjectContext.mr_()
    
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
        let profileOne = CDProfile.mr_createEntity(in: context)!
        profileOne.title = "Title one"
        profileOne.teacherNick = "Teacher one"
        profileOne.link = "Link one"


        let profileTwo = CDProfile.mr_createEntity(in: context)!
        profileTwo.title = "Title two"
        profileTwo.teacherNick = "Teacher two"
        profileTwo.link = "Link two"
        
        return [profileOne, profileTwo]
    }
    
    func findObjects(by key: String, value: String) {
        if value == "" {
            profilesFromCoreData.value = []
        } else {
            let profileOne = CDProfile.mr_createEntity(in: context)
            profileOne?.title = "Title one"
            profileOne?.teacherNick = "Teacher one"
            profileOne?.link = "Link one"
            profilesFromCoreData.value = [profileOne! as NSManagedObject]
        }
    }
    
    func findObjects(by predicate: NSPredicate) {
        profilesFromCoreData.value = []
    }
}
