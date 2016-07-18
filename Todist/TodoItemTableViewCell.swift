//
//  TodoItemTableViewCell.swift
//  Todist
//
//  Created by Patrick Devine on 7/17/16.
//  Copyright © 2016 interview.assignment. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    @IBOutlet weak var displayDescription: UILabel!
    @IBOutlet weak var deadline: UILabel!
    @IBOutlet weak var progress: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
