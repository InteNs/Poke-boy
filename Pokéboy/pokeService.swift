//
//  pokeService.swift
//  Pokéboy
//
//  Created by Mark Havekes on 08/04/2018.
//  Copyright © 2018 Mark Havekes. All rights reserved.
//

import Foundation
import UIKit

class PokeService {
    let baseUrl = "http://pokeapi.co/api/v2/pokemon/"
    
    func getImage(url: String, completion: @escaping(UIImage?) -> ()) {
        getDataFromUrl(url: URL(string: url)!) { (data, res, err) in
            completion(UIImage(data: data!))
        }
    }
    
    func getPokemon(id: Int, completion: @escaping (PokemonResult?) -> ()) {
        getDataFromUrl(url: URL(string: baseUrl + String(id))!) { (data, res, err) in
            guard let pokemon = try? JSONDecoder().decode(PokemonResult.self, from: data!) else {
                print("Error: Couldn't decode data into pokemon")
                return
            }
            completion(pokemon)
        }
    }
    
    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            }.resume()
    }
    
}
