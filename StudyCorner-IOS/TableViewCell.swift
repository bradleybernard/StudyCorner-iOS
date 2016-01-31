//
//  TableViewCell.swift
//  StudyCorner-IOS
//
//  Created by Aidan Gadberry on 1/30/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var prioritySwitch: UISwitch!
    @IBOutlet weak var className: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    typealias SwitchCallback = (Bool) -> Void
    var switchCallback: SwitchCallback?
    
    @IBAction func switchChangedState(sender: UISwitch) {
        switchCallback?(sender.on)
    }
    
}
