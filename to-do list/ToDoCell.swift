//
//  ToDoCell.swift
//  to-do list
//
//  Created by Paulina Van der Doe on 07/03/2018.
//  Copyright © 2018 Paulina Van der Doe. All rights reserved.
//

import UIKit

@objc protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCell)
}
var delegate: ToDoCellDelegate?

class ToDoCell: UITableViewCell {
    
    // Make delegate.
    var delegate: ToDoCellDelegate?
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    /// If button is tapped, change checkmark.
    @IBAction func completeButtonTapped() {
        delegate?.checkmarkTapped(sender: self)
    }
    
        
}
