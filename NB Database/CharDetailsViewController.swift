//
//  CharDetailsViewController.swift
//  NB Database
//
//  Created by Nikhil on 7/09/18.
//  Copyright © 2018 Nikhil. All rights reserved.
//

import UIKit
import CoreData

class CharDetailsViewController: UIViewController {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //outlets for UI
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var ancestryLabel: UILabel!
    
    var getImage = UIImage()
    var name = String()
    var house = String()
    var ancestry = String()
    var imageUrlString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = getImage
        nameLabel.text! = name
        houseLabel.text! = house
        ancestryLabel.text! = ancestry
        
        if let imageURL = URL(string: imageUrlString)
        {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }

    }
    

    @IBAction func saveButton(_ sender: UIButton) {
        
        let entity = NSEntityDescription.entity(forEntityName: "PersonCharacte", in: context)
        let newPersonCharacter = NSManagedObject(entity: entity!, insertInto: context)
        
        newPersonCharacter.setValue(name, forKey: "name")
        newPersonCharacter.setValue(ancestry, forKey: "ancestry")
        newPersonCharacter.setValue(house, forKey: "house")
        
        do{
            try context.save()
            print("Saved")
        }
        catch{
          print("Save Failed")
        }
    }
}
