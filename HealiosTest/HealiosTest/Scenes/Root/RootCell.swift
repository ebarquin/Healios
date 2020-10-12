//
//  RootCell.swift
//  HealiosTest
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import UIKit

class RootCell: UITableViewCell {
    @IBOutlet weak var postTitleLabel: UILabel!
    
    var post: Post?
    
    func configureCell (with post: Post) {
        postTitleLabel.text = post.title
        self.post = post
    }
}
