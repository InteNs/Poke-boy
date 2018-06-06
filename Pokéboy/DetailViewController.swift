//
//  DetailViewController.swift
//  Pokéboy
//
//  Created by Mark Havekes on 06/04/2018.
//  Copyright © 2018 Mark Havekes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var pokeService: PokeService? = nil
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let imageView = image {
                self.pokeService!.getImage(url: detail.sprite!) { (image) in
                    DispatchQueue.main.async() {
                        imageView.contentMode = .scaleAspectFit
                        imageView.image = image
                    }
                }
            }
            if let label = detailDescriptionLabel {
                label.text = detail.name
            }
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Pokemon? {
        didSet {
            // Update the view.
            configureView()
        }
    }
}

