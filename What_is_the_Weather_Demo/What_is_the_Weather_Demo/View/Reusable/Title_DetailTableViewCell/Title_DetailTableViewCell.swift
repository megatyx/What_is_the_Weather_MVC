//
//  Title_DetailTableViewCell.swift
//  What_is_the_Weather_Demo
//
//  Created by Tyler Wells on 3/22/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit

class Title_DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
