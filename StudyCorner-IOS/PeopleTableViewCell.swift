//
//  PeopleTableViewCell.swift
//  StudyCorner-IOS
//
//  Created by Spencer Albrecht on 1/31/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var nameLabel: UILabel!
}
