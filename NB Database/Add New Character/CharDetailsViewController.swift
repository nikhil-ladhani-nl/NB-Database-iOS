//
//  CharDetailsViewController.swift
//  NB Database
//
//  Created by Nikhil on 7/09/18.
//  Copyright © 2018 Nikhil. All rights reserved.
//

import UIKit
import CoreData

func showMessage(_ msg : String, _ type : String, _ viewContoller: UIViewController)
{
    let alertController = UIAlertController(title: type, message: msg, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK", style: .default)
    {
        action in viewContoller.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(alertAction)
    viewContoller.present(alertController, animated: true, completion: nil)
}

class CharDetailsViewController: UIViewController {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Outlets for UI
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var ancestryLabel: UILabel!
    
    //Varibables for UI
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
    
    //Saving the JSON Data in Core Data
    @IBAction func saveButton(_ sender: UIButton) {
        
        let entity = NSEntityDescription.entity(forEntityName: "SavedCharacters", in: context)
        let newPersonCharacter = NSManagedObject(entity: entity!, insertInto: context)
        
        newPersonCharacter.setValue(name, forKey: "name")
        newPersonCharacter.setValue(ancestry, forKey: "ancestry")
        newPersonCharacter.setValue(house, forKey: "house")

        do{
            try context.save()
            showMessage("Character Saved Successfully","Success", self)
            
        }
        catch{
          showMessage("Character Saved Successfully","Error", self)
        }
    }
}
