//
//  NewsItemTableViewCell.swift
//  StretchMyHeader
//
//  Created by KevinT on 2018-03-27.
//  Copyright © 2018 KevinT. All rights reserved.
//

import UIKit

class NewsItemTableViewCell: UITableViewCell {

  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var headlineLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
