//
//  OutboxMessagesTableViewCell.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 4/7/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit

class OutboxMessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var contactField: UILabel!
    @IBOutlet weak var messageField: UILabel!
    @IBOutlet weak var typeField: UILabel!
    @IBOutlet weak var radiusField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
