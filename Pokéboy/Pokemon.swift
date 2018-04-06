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
    let weight: Int32
    let sprites: Sprites
}

struct Sprites: Decodable {
    let front_default: String
}
