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


class CharacterTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    //Array of characters from a Model
    var charactersData = [PersonCharacter]()
    var filteredCharacters = [PersonCharacter]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setUpSearchBar()
        alterLayout()
    }
    private func array(){
        filteredCharacters = charactersData
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
        
        return filteredCharacters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharTableViewCell
        
    // Displaying name & house in table view cell
        cell.nameLabel.text = "Name: " +  filteredCharacters[indexPath.row].name
        cell.ancestryLabel.text = "Ancestry: " +  filteredCharacters[indexPath.row].ancestry
        cell.houseLabel.text = "House: " + filteredCharacters[indexPath.row].house
        
        // Displaying image in table view cell
        if let imageURL = URL(string: self.filteredCharacters[indexPath.row].image) {
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
        hpc?.imageUrlString = filteredCharacters[indexPath.row].image
        hpc?.name = filteredCharacters[indexPath.row].name
        hpc?.ancestry = filteredCharacters[indexPath.row].ancestry
        hpc?.house = filteredCharacters[indexPath.row].house
        self.navigationController?.pushViewController(hpc!, animated: true)
    }
    
    //Search Functions
    func alterLayout()
    {
        definesPresentationContext = true
        searchBar.placeholder = "Enter detail you want to search by"
        tableView.tableHeaderView = searchBar
    }
    func setUpSearchBar()
    {
        searchBar.delegate = self
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredCharacters = charactersData
            table.reloadData()
            return }
        filteredCharacters = charactersData.filter({ personCharacter -> Bool in
            personCharacter.name.lowercased().contains(searchText.lowercased())||personCharacter.house.lowercased().contains(searchText.lowercased())||personCharacter.ancestry.lowercased().contains(searchText.lowercased())
        })
        table.reloadData()
    }

}
