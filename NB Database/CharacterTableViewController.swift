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
//array of characters
    var charactersData = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData()
    {
        //speeds up loading process
        DispatchQueue.main.async {
            //fetching the data from the url
            Alamofire.request("http://hp-api.herokuapp.com/api/characters").responseJSON(completionHandler: {
                (response) in
                switch response.result
                {
              //outcomes of switch
                case.success(let value):
                    let json = JSON(value)
                    print(json)
                    json.array?.forEach({
                        (character) in
                        //pick specific attributes from the json array, display on table view
                        let character = Character(name: character["name"].stringValue, house:character["house"].stringValue,image:character["image"].stringValue, gender: character["gender"].stringValue, ancestry: character["ancestry"].stringValue)
                        //prints out content of characters
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
//sets rows in table view depending on entity amount
        return charactersData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharTableViewCell
    // displaying name & house in table view cell
        cell.nameLabel.text = "Name: " +  charactersData[indexPath.row].name
        cell.houseLabel.text = "House: " + charactersData[indexPath.row].house
        // displaying image in table view cell
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
        //passes data from table view cell into details view controller
        hpc?.imageUrlString = charactersData[indexPath.row].image
        hpc?.name = charactersData[indexPath.row].name
        hpc?.house = charactersData[indexPath.row].house
        self.navigationController?.pushViewController(hpc!, animated: true)
    }


}
