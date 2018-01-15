//
//  ProfileCellViewModel.swift
//  DemoApp
//
//  Created by Marcin Srech on 14.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import Foundation


class ProfileCellViewModel {
    
    //MARK: - Properties
    private let profile: CDProfile
    var teacherNick: String { return profile.teacherNick ?? "" }
    var title: String { return profile.title ?? "" }
    
    //MARK: - Life cycle
    init(profile: CDProfile) {
        self.profile = profile
    }
    
    public func getLink() -> String {
        return profile.link ?? ""
    }
}
