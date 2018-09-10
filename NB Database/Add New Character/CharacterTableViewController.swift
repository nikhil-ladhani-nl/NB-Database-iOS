//
//  CharacterTableViewController.swift
//  NB Database
//
//  Created by Nikhil on 7/09/18.
//  Copyright © 2018 Nikhil. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class CharacterTableViewController: UITableViewController {
    
    //Array of characters from a Model
    var charactersData = [PersonCharacter]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData()
    {
        //Speeds up the Loading Process from a long queue
        DispatchQueue.main.async {
            
            //Fetching the Data from the url as JSON Format
            Alamofire.request("http://hp-api.herokuapp.com/api/characters").responseJSON(completionHandler: {
                (response) in
                switch response.result
                {
                    
              //Outcomes of switch like an advanced if function
                case.success(let value):
                    let json = JSON(value)
                    print(json)
                    json.array?.forEach({
                        (character) in
                        
                        //Pick specific attributes from the json array, display on table view
                        let character = PersonCharacter(name: character["name"].stringValue, house:character["house"].stringValue,image:character["image"].stringValue, ancestry: character["ancestry"].stringValue)
                        
                        //Prints out content of characters
                        self.charactersData.append(character)
                    })
                    //reloads table to display the data
                    self.tableView.reloadData()
                    
                    //outcome of switch
                case.failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Sets rows in table view depending on entity amount
        return charactersData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharTableViewCell
        
    // Displaying name & house in table view cell
        cell.nameLabel.text = "Name: " +  charactersData[indexPath.row].name
        cell.ancestryLabel.text = "Ancestry: " +  charactersData[indexPath.row].ancestry
        cell.houseLabel.text = "House: " + charactersData[indexPath.row].house
        
        // Displaying image in table view cell
        if let imageURL = URL(string: self.charactersData[indexPath.row].image) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.charImageView.image = image
                    }
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let hpc = storyboard?.instantiateViewController(withIdentifier: "CharDetails") as? CharDetailsViewController
        
        //Passes data from table view cell into details view controller
        hpc?.imageUrlString = charactersData[indexPath.row].image
        hpc?.name = "Name: " + charactersData[indexPath.row].name
        hpc?.ancestry = "Ancestry: " + charactersData[indexPath.row].ancestry
        hpc?.house = "House: " + charactersData[indexPath.row].house
        self.navigationController?.pushViewController(hpc!, animated: true)
    }


}
