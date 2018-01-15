//
//  ProfileTableViewCell.swift
//  DemoApp
//
//  Created by Marcin Srech on 14.01.2018.
//  Copyright © 2018 Marcin Srech. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        detailTextLabel?.numberOfLines = 0
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func setup(viewModel: ProfileCellViewModel) {
        textLabel?.text = viewModel.teacherNick
        detailTextLabel?.text = viewModel.title
    }

}
