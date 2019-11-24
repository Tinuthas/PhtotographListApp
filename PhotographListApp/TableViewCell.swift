//
//  TableViewCell.swift
//  PhotographListApp
//
//  Created by Marcus Vinicius Galdino Medeiros on 23/11/19.
//  Copyright © 2019 Marcus Vinicius Galdino Medeiros. All rights reserved.
//
import UIKit

public class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lazyImageView: UIImageView!
    @IBOutlet weak var lazyTextView: UILabel!
    

override public func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
}

override public func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
}

}
