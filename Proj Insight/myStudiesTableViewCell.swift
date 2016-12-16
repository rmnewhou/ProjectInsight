//
//  myStudiesTableViewCell.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-10-24.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import Foundation
import UIKit

class myStudiesTableViewCell: UITableViewCell {
    // MARK: Properties
    
    @IBOutlet weak var myStudyName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
