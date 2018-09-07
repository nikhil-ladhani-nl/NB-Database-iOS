//
//  TableViewController.swift
//  NB Database
//
//  Created by Nikhil on 7/09/18.
//  Copyright © 2018 Nikhil. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {

    var charactersData = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
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
                
                json.array?.forEach({
                    (character) in
                    let character = Character(name: character["name"].stringValue, house: character["house"].stringValue)
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

        return charactersData.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharacterTableViewCell

        cell.nameLabel.text = charactersData[indexPath.row].name
        cell.hairColourLabel.text = charactersData[indexPath.row].house

        return cell
    }


}
