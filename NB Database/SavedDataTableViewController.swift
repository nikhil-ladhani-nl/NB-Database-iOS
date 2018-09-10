//
//  SavedDataTableViewController.swift
//  NB Database
//
//  Created by Nikhil on 10/09/18.
//  Copyright © 2018 Nikhil. All rights reserved.
//

import UIKit
import CoreData

class SavedDataTableViewController: UITableViewController {

    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ancestryLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    
    var getImage = UIImage()
    var name = String()
    var house = String()
    var ancestry = String()
    var imageUrlString = String()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charImageView.image = getImage
        nameLabel.text! = name
        houseLabel.text! = house
        ancestryLabel.text! = ancestry
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    func getData(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonCharacte")
        request.returnsObjectsAsFaults = false
        do{
            let result = try? context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                name = data.value(forKey: "name") as! String
                house = data.value(forKeyPath: "house") as! String
            }
        }
        
    }
    
}
