//
//  ActivityTableViewCell.swift
//  Shellder
//
//  Created by Robert Demuth on 10/25/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
