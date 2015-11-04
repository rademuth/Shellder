//
//  CheckControl.swift
//  Shellder
//
//  Created by Robert Demuth on 11/2/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import UIKit

class CheckControl: UIView {

    // MARK: Properties
    
    var checked = 0
    var button = UIButton()
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let checkedImage = UIImage(named: "checked")
        let uncheckedImage = UIImage(named: "unchecked")
        
        button.setImage(uncheckedImage, forState: .Normal)
        button.setImage(checkedImage, forState: .Selected)
        
        button.addTarget(self, action: "checkboxTapped:", forControlEvents: .TouchDown)
        
        addSubview(button)
        
        
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        button.frame = CGRect(x:0, y:0, width: buttonSize, height: buttonSize)
        updateCheckboxSelectionState()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        return CGSize(width: buttonSize, height: buttonSize)
    }
    
    // MARK: Button Action
    
    func checkboxTapped(button: UIButton) {
        if checked == 0 {
            print("Checked the button")
            checked = 1
        } else if checked == 1 {
            print("Unchecked the button")
            checked = 0
        }
        updateCheckboxSelectionState()
    }
    
    func updateCheckboxSelectionState() {
        if checked == 0 {
            button.selected = false
        } else if checked == 1 {
            button.selected = true
        }
    }

}
