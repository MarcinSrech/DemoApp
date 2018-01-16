//
//  ProfileCellViewModelTests.swift
//  DemoAppTests
//
//  Created by Marcin Srech on 16.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import XCTest
import MagicalRecord
@testable import DemoApp

class ProfileCellViewModelTests: XCTestCase {
    
    let context = NSManagedObjectContext.mr_()
    var viewModel: ProfileCellViewModel?
    var viewModelWithNilValue: ProfileCellViewModel?
    let title = "TestTitle"
    let teacherNick = "TestTeacher"
    let link = "TestLink"
    
    override func setUp() {
        super.setUp()
        
        let profile = CDProfile.mr_createEntity(in: context)
        profile?.title = title
        profile?.teacherNick = teacherNick
        profile?.link = link
        viewModel = ProfileCellViewModel(profile: profile!)
        
        let profile2 = CDProfile.mr_createEntity(in: context)
        viewModelWithNilValue = ProfileCellViewModel(profile: profile2!)
    }
    
    override func tearDown() {
        context.rollback()
            
        super.tearDown()
    }
    
    func testGetCorrectTitle() {
        XCTAssertEqual(viewModel?.title, title)
    }
    
    func testGetCorrectTitleWhenTitleIsNil() {
        XCTAssertEqual(viewModelWithNilValue?.title, "")
    }
    
    func testGetCorrectTeacher() {
        XCTAssertEqual(viewModel?.teacherNick, teacherNick)
    }
    
    func testGetCorrectTitleWhenTeacherIsNil() {
        XCTAssertEqual(viewModelWithNilValue?.teacherNick, "")
    }

    func testGetCorrectLink() {
        XCTAssertEqual(viewModel?.getLink(), link)
    }
    
    func testGetCorrectTitleWhenLinkIsNil() {
        XCTAssertEqual(viewModelWithNilValue?.getLink(), "")
    }

}
