//
//  Characters.swift
//  NB Database
//
//  Created by Nikhil on 7/09/18.
//  Copyright © 2018 Nikhil. All rights reserved.
//

import Foundation

class PersonCharacter
{
    var name : String
    var house : String
    var image : String
    var ancestry : String
    
    init(name: String, house: String, image: String, ancestry: String)
    {
        self.name = name
        self.house = house
        self.image = image
        self.ancestry = ancestry
    }
}
