//
//  HTMLParserTests.swift
//  DemoAppTests
//
//  Created by Marcin Srech on 15.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import XCTest
@testable import DemoApp

class HTMLParserTests: XCTestCase {
    
    var htmlStringTwoActiveProfiles: String?
    var htmlStringOneActiveProfiles: String?
    
    override func setUp() {
        super.setUp()
        
        htmlStringTwoActiveProfiles = getTwoActiveProfiles()
        htmlStringOneActiveProfiles = getOneActiveProfile()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseTwoActiveProfiles() {
        let expectedCount = 2
        let profiles = HTMLParser.parseProfiles(htmlStringTwoActiveProfiles!)
        
        XCTAssertEqual(profiles.count, expectedCount)
    }
    
    func testParseOneActiveProfile() {
        let expectedCount = 1
        let profiles = HTMLParser.parseProfiles(htmlStringOneActiveProfiles!)
        
        XCTAssertEqual(profiles.count, expectedCount)
    }

    //MARK: - Helpers
    
    func getTwoActiveProfiles() -> String {
        return """
        <div class="span12 contentLayout" id="categoryPage">
        <div class="profileMain inactive " onclick="document.location.href='/profile/show-profile/31502/basic-tagalog-basic-english-tutorials'">
        <div style="display: inline;">
        
        <div class="profileMainAvatar labelOffline">
        <div class="profileMainAvatarOverlay"></div>
        <img src="/cache/img/frontend/avatars/1369730018_0130x0130_dd409fa0a4c80009df3f129d3a2ade02.jpg" alt="kai.austria" width="97" height="130">                    </div>
        
        </div>
        <div class="profileMainContent">
        <div class="profileMainTitle">
        <a href="/profile/show-profile/31502/basic-tagalog-basic-english-tutorials">Basic Tagalog / Basic English tutorials</a>
        </div>
        <div class="profileMainRate">
        <span class="rates">
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        </span>
        <span class="profileMainScore">Score: <strong>0</strong></span>
        </div>
        <div class="profileMainPrice"><strong>9.60 USD</strong> / 1h</div>
        <div class="profileMainCategory">Languages / Other</div>
        <div class="profileMainNick">kai.austria</div>
        </div>
        <div class="profileMainDesc">
        Mabuhay! Are you interested in learning Philippine's Basic Language? Learn Basic Tagalog with me and I'd be more than happy to teach you the language. =)
        Want to learn the Basics of the English Language?
        This sure can be handy and I can teach you how to speak and use English in...    </div>
        <div class="profileMainButton">
        <button type="button" class="button button-medium flat green">
        <span>SEE PROFILE</span>
        </button>
        </div>
        </div>
        <div class="profileMain inactive " onclick="document.location.href='/profile/show-profile/30744/it-tamil-webdesigning-vbscript-javascript-webdevelopment'">
        <div style="display: inline;">
        
        <div class="profileMainAvatar labelOffline">
        <div class="profileMainAvatarOverlay"></div>
        </div>
        
        </div>
        <div class="profileMainContent">
        <div class="profileMainTitle">
        <a href="/profile/show-profile/30744/it-tamil-webdesigning-vbscript-javascript-webdevelopment">IT, Tamil, Webdesigning, VBScript Javascript..webdevelopment</a>
        </div>
        <div class="profileMainRate">
        <span class="rates">
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        </span>
        <span class="profileMainScore">Score: <strong>0</strong></span>
        </div>
        <div class="profileMainPrice"><strong>0.00 USD</strong> / 1h</div>
        <div class="profileMainCategory">Languages / Other</div>
        <div class="profileMainNick">badhrig</div>
        </div>
        <div class="profileMainDesc">
        I have 6 yrs of experience in IT, and have created 6 websites so4 individually, which are ASP and database driven...well versed in English and Tamil languages, and all other programing language, have diversified knowladge in IT. (CitrixCertifiedAssociate). Initially I'am starting...    </div>
        <div class="profileMainButton">
        <button type="button" class="button button-medium flat green">
        <span>SEE PROFILE</span>
        </button>
        </div>
        </div>
        </div>
        """
    }
    
    func getOneActiveProfile() -> String {
        return """
        <div class="span12 contentLayout" id="categoryPage">
        <div class="profileMain inactive " onclick="document.location.href='/profile/show-profile/31502/basic-tagalog-basic-english-tutorials'">
        <div style="display: inline;">
        
        <div class="profileMainAvatar labelOffline">
        <div class="profileMainAvatarOverlay"></div>
        <img src="/cache/img/frontend/avatars/1369730018_0130x0130_dd409fa0a4c80009df3f129d3a2ade02.jpg" alt="kai.austria" width="97" height="130">                    </div>
        
        </div>
        <div class="profileMainContent">
        <div class="profileMainTitle">
        <a href="/profile/show-profile/31502/basic-tagalog-basic-english-tutorials">Basic Tagalog / Basic English tutorials</a>
        </div>
        <div class="profileMainRate">
        <span class="rates">
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        </span>
        <span class="profileMainScore">Score: <strong>0</strong></span>
        </div>
        <div class="profileMainPrice"><strong>9.60 USD</strong> / 1h</div>
        <div class="profileMainCategory">Languages / Other</div>
        <div class="profileMainNick">kai.austria</div>
        </div>
        <div class="profileMainDesc">
        Mabuhay! Are you interested in learning Philippine's Basic Language? Learn Basic Tagalog with me and I'd be more than happy to teach you the language. =)
        Want to learn the Basics of the English Language?
        This sure can be handy and I can teach you how to speak and use English in...    </div>
        <div class="profileMainButton">
        <button type="button" class="button button-medium flat green">
        <span>SEE PROFILE</span>
        </button>
        </div>
        </div>
        <div class="profileMain " onclick="document.location.href='/profile/show-profile/30744/it-tamil-webdesigning-vbscript-javascript-webdevelopment'">
        <div style="display: inline;">
        
        <div class="profileMainAvatar labelOffline">
        <div class="profileMainAvatarOverlay"></div>
        </div>
        
        </div>
        <div class="profileMainContent">
        <div class="profileMainTitle">
        <a href="/profile/show-profile/30744/it-tamil-webdesigning-vbscript-javascript-webdevelopment">IT, Tamil, Webdesigning, VBScript Javascript..webdevelopment</a>
        </div>
        <div class="profileMainRate">
        <span class="rates">
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        <i class="rate "></i>
        </span>
        <span class="profileMainScore">Score: <strong>0</strong></span>
        </div>
        <div class="profileMainPrice"><strong>0.00 USD</strong> / 1h</div>
        <div class="profileMainCategory">Languages / Other</div>
        <div class="profileMainNick">badhrig</div>
        </div>
        <div class="profileMainDesc">
        I have 6 yrs of experience in IT, and have created 6 websites so4 individually, which are ASP and database driven...well versed in English and Tamil languages, and all other programing language, have diversified knowladge in IT. (CitrixCertifiedAssociate). Initially I'am starting...    </div>
        <div class="profileMainButton">
        <button type="button" class="button button-medium flat green">
        <span>SEE PROFILE</span>
        </button>
        </div>
        </div>
        </div>
        """
    }
}
