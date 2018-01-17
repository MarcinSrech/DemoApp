//
//  ProfilesListViewModelTests.swift
//  DemoAppTests
//
//  Created by Marcin Srech on 16.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import XCTest
@testable import DemoApp

class ProfilesListViewModelTests: XCTestCase {
    
    let dataProvider = MockupCDProfileDataProvider()
    var viewModel: ProfilesListViewModel?
    
    override func setUp() {
        super.setUp()
        
        viewModel = ProfilesListViewModel(dataProvider: dataProvider)
    }
    
    override func tearDown() {
        dataProvider.context.rollback()
        
        super.tearDown()
    }
    
    func testGetCorrectTitle() {
        let expectedTitle = String.localized("ProfilesVC_title")
        
        XCTAssertEqual(viewModel?.title, expectedTitle)
    }
    
    func testGetEmptyArrayOfProfiles() {
        let expectedCount = 0

        XCTAssertEqual(viewModel?.getProfiles().value.count, expectedCount)
    }
    
    func testGetAllProfiles() {
        let expectedCount = 2
        
        XCTAssertEqual(viewModel?.getProfiles().value.count, 0)
        
        dataProvider.loadAllObjects()
        
        XCTAssertEqual(viewModel?.getProfiles().value.count, expectedCount)
    }
    
    func testFindOneProfiles() {
        let expectedCount = 1
        
        XCTAssertEqual(viewModel?.getProfiles().value.count, 0)
        
        dataProvider.findObjects(by: "test", value: "test")
        
        XCTAssertEqual(viewModel?.getProfiles().value.count, expectedCount)
    }
    
    func testFindWithoutValue() {
        let expectedCount = 0
        
        XCTAssertEqual(viewModel?.getProfiles().value.count, 0)
        
        dataProvider.findObjects(by: "test", value: "")
        
        XCTAssertEqual(viewModel?.getProfiles().value.count, expectedCount)
    }
    
    func testNoErrorApi() {
        let expectedValue = false
        
        XCTAssertEqual(viewModel?.getErrorAppears().value, expectedValue)
    }
    
    
}
