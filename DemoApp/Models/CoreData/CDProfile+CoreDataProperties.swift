//
//  CDProfile+CoreDataProperties.swift
//  DemoApp
//
//  Created by Marcin Srech on 12.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//
//

import Foundation
import CoreData


extension CDProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProfile> {
        return NSFetchRequest<CDProfile>(entityName: "CDProfile")
    }

    @NSManaged public var title: String?
    @NSManaged public var teacherNick: String?
    @NSManaged public var link: String?

}
