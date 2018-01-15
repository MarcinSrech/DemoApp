//
//  AppSettingsTests.swift
//  DemoAppTests
//
//  Created by Marcin Srech on 15.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import XCTest
@testable import DemoApp

class AppSettingsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCorrectLoadSettings() {
        let appSettings = AppSettings()
        
        let filePath = Bundle.main.path(forResource: "AppSettings", ofType: "plist")
        let settingsFromPlist = NSDictionary(contentsOfFile: filePath!) as! [String : Any]
        
        var environment = "prod"
        #if DEBUG
            environment = "dev"
        #endif

        XCTAssertEqual(appSettings.baseUrl, (settingsFromPlist["baseUrl"] as! [String:String])[environment]!)
    }
    
    func testWrongLoadSettings() {
        let appSettings = AppSettings()
        
        XCTAssertNotEqual(appSettings.baseUrl, "test")
    }
    
    
}
