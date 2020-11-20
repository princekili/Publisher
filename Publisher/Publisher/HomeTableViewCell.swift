//
//  HomeTableViewCell.swift
//  Publisher
//
//  Created by prince on 2020/11/20.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    
    func setup(title: String,
               name: String,
               time: String,
               category: String,
               content: String) {
        
        titleLabel.text = title
        nameLabel.text = name
        timeLabel.text = time
        categoryLabel.text = category
        contentLabel.text = content
    }
}
