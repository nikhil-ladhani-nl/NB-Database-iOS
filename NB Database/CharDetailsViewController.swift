//
//  CharDetailsViewController.swift
//  NB Database
//
//  Created by Nikhil on 7/09/18.
//  Copyright © 2018 Nikhil. All rights reserved.
//

import UIKit

class CharDetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var ancestryLabel: UILabel!
    
    var getImage = UIImage()
    var name = String()
    var gender = String()
    var house = String()
    var ancestry = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = getImage
        nameLabel.text! = name
        houseLabel.text! = house

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
