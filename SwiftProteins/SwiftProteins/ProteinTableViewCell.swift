//
//  ProteinTableViewCell.swift
//  SwiftProteins
//
//  Created by Igor Chemencedji on 8/11/17.
//  Copyright © 2017 Igor Chemencedji. All rights reserved.
//

import UIKit

class ProteinTableViewCell: UITableViewCell {

    @IBOutlet weak var proteinName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
