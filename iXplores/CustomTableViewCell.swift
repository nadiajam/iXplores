//
//  CustomTableViewCell.swift
//  iXplores
//
//  Created by Nadia Jamrozik on 7/14/16.
//  Copyright © 2016 Nadia Jamrozik. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var customImage: UIImageView!
    @IBOutlet weak var customTitle: UILabel!
    @IBOutlet weak var customDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
