//
//  Pokemon.swift
//  Pokéboy
//
//  Created by Mark Havekes on 06/04/2018.
//  Copyright © 2018 Mark Havekes. All rights reserved.
//

import Foundation
import CoreData

struct PokemonResult: Decodable {
    let id: Int32
    let name: String
    let base_experience: Int32
    let sprites: Sprites
    
//    init() {
//        self.name = ""
//        self.id = 0
//        self.baseExperience = 0
//        self.sprites = Sprites(front_default: "")
//    }
}

struct Sprites: Decodable {
    let front_default: String
}
