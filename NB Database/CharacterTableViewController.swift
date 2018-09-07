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

    var charactersData = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData()
    {
        DispatchQueue.main.async {
            Alamofire.request("http://hp-api.herokuapp.com/api/characters").responseJSON(completionHandler: {
                (response) in
                switch response.result
                {
                case.success(let value):
                    let json = JSON(value)
                    print(json)
                    json.array?.forEach({
                        (character) in
                        let character = Character(name: character["name"].stringValue, house:character["house"].stringValue,characterImage:character["image"].stringValue)
                        self.charactersData.append(character)
                    })
                    self.tableView.reloadData()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return charactersData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        
//        cell.nameLabel.text = "Name: " +  self.charactersData[indexPath.row].name
//        cell.houseLabel.text = "House: " + self.charactersData[indexPath.row].house
//
//        if let imageURL = URL(string: self.charactersData[indexPath.row].characterImage) {
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: imageURL)
//                if let data = data {
//                    let image = UIImage(data: data)
//                    DispatchQueue.main.async {
//                        cell.characterImageView.image = image
//                    }
//                }
//            }
//        }
        return cell
    }


}
