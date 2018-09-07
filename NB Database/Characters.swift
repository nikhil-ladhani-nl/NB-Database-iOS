//
//  Characters.swift
//  NB Database
//
//  Created by Nikhil on 7/09/18.
//  Copyright © 2018 Nikhil. All rights reserved.
//

import Foundation

class Character
{
    var name : String
    var house : String
    var image : String
    
    init(name: String, house: String, image: String)
    {
        self.name = name
        self.house = house
        self.image = image
    }
}
