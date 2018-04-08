//
//  SafariController.swift
//  Pokéboy
//
//  Created by Mark Havekes on 06/04/2018.
//  Copyright © 2018 Mark Havekes. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SafariController : UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var catchButton: UIButton!
    
    var managedObjectContext: NSManagedObjectContext? = nil
    var pokeService: PokeService? = nil
    var pokemon = PokemonResult(id: 0, name: "", base_experience: 0, sprites: Sprites(front_default: ""))
    
    @IBAction func run(_ sender: Any) {
        fetchPokemon()
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchPokemon()
    }
    
    @IBAction func catchPokemon(_ sender: UIButton) {
        var chance = 70
        if(pokemon.base_experience > 100) {
            chance = chance - 25
        }
        if(pokemon.base_experience > 200) {
            chance = chance - 20
        }
        if(pokemon.base_experience > 300) {
            chance = chance - 10
        }
        if(Int(arc4random_uniform(100)) > chance) {
            after_action(caught: false)
            return
        }
        
        let newPokemon = NSEntityDescription.insertNewObject(forEntityName: "Pokemon", into: managedObjectContext!) as! Pokemon
        
        newPokemon.name = pokemon.name
        newPokemon.id = pokemon.id
        newPokemon.sprite = pokemon.sprites.front_default

        do {
            try managedObjectContext!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        after_action(caught: true)
        
    }
    
    private func after_action(caught: Bool) {
        var alert: UIAlertController? = nil
        if(caught) {
            alert = UIAlertController(title: "Congratulations!", message: "You've caught a " + pokemon.name + " !", preferredStyle: .alert)
        } else {
            alert = UIAlertController(title: "Darn!", message: pokemon.name + " got away!", preferredStyle: .alert)
        }
        
        alert!.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert!, animated: true)
        fetchPokemon()
    }
    
    private func displayPokemon() {
        DispatchQueue.main.async {
            self.name.text = self.pokemon.name
            self.catchButton.isEnabled = true
        }
        fetchImage(url: self.pokemon.sprites.front_default)
    }
    
    private func clearPokemon() {
        DispatchQueue.main.async {
            self.name.text = "?"
            self.catchButton.isEnabled = false
            self.image.image = #imageLiteral(resourceName: "placeholder")
        }
    }
    
    private func fetchPokemon() {
        clearPokemon()
        let id = Int(arc4random_uniform(150))
        pokeService!.getPokemon(id: id) { (pokemon) in
            self.pokemon = pokemon!
            self.displayPokemon()
        }
    }
    
    private func fetchImage(url: String) {
        pokeService!.getImage(url: self.pokemon.sprites.front_default) { (image) in
            DispatchQueue.main.async() {
                self.image.contentMode = .scaleAspectFit
                self.image.image = image
            }
        }
    }
}
