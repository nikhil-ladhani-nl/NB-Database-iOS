//
//  CharTableViewCell.swift
//  
//
//  Created by Nikhil on 8/09/18.
//

import UIKit

class CharTableViewCell: UITableViewCell {

//outlets for UI
    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
