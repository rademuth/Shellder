//
//  ScoreTableViewCell.swift
//  Shellder
//
//  Created by Robert Demuth on 11/18/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
