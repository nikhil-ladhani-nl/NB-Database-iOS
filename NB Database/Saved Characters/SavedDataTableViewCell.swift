//
//  SavedDataTableViewCell.swift
//  NB Database
//
//  Created by Nikhil on 10/09/18.
//  Copyright © 2018 Nikhil. All rights reserved.
//

import UIKit

class SavedDataTableViewCell: UITableViewCell {

    //Outlets form the Table View Cell
    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ancestryLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
