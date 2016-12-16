//
//  TaskCell.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-11-10.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import Foundation
import UIKit

class TaskCell: UITableViewCell {
    // MARK: Properties
    
    @IBOutlet weak var taskImage: UIImageView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var taskTypeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
