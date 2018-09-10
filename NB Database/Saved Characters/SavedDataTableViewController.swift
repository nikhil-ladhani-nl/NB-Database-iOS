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

    //Array Variables
    var charData = [SavedCharacters]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calling the Function for fetching saved core data
        getData()
    }
    
    //Function for Fetching the saved Core Data
    func getData(){
    
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //A request made from the model with its attributes
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedCharacters")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try? context.fetch(request)
            for data in result as! [NSManagedObject]
            {
            //Show output data on the device
            charData.append(data as! SavedCharacters)
            }
        }
        tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charData.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! SavedDataTableViewCell
        
        let char = charData[indexPath.row]

        cell.nameLabel.text = char.name!
        cell.houseLabel.text = char.house!
        cell.ancestryLabel.text = char.ancestry!
//        cell.charImageView.image = char.image!

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hpsc = storyboard?.instantiateViewController(withIdentifier: "SavedDetails") as? SavedDataViewController
        
        //Passes data from table view cell into details view controller
//        hpsc?.imageUrlString = charData[indexPath.row].image!
        hpsc?.name = charData[indexPath.row].name!
        hpsc?.ancestry = charData[indexPath.row].ancestry!
        hpsc?.house = charData[indexPath.row].house!
        
        self.navigationController?.pushViewController(hpsc!, animated: true)
    }
    
}
