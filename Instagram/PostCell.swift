//
//  PostCell.swift
//  Instagram
//
//  Created by Jesus Andres Bernal Lopez on 9/26/18.
//  Copyright © 2018 Jesus Andres Bernal Lopez. All rights reserved.
//

import UIKit
import ParseUI

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
