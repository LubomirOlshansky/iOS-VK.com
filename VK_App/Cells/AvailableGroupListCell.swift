//
//  AvailableGroupListCell.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 22/09/2017.
//  Copyright © 2017 Lubomir Olshansky. All rights reserved.
//

import UIKit

class AvailableGroupListCell: UITableViewCell {

    @IBOutlet weak var groupPhoto: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupUserCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
