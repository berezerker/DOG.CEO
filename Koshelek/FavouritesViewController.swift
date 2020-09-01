//
//  FavouritesViewController.swift
//  Koshelek
//
//  Created by Berezkin on 29.08.2020.
//  Copyright © 2020 Berezerker. All rights reserved.
//

import UIKit
import RealmSwift

class FavouritesViewController: UIViewController {

    var favBreeds = Persistance.shared.allBreeds()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Persistance.shared.clear()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FavouriteDetailsViewController, segue.identifier == "ShowFavBreedDetails"{
            let position = sender as! IndexPath
            vc.breed = favBreeds[position.row]
        }
    }

}

extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell") as! FavouritesTableViewCell
        let breed = favBreeds[indexPath.row]
        cell.nameLabel.text = "\(breed.name)"
        cell.nameLabel.text! += " (\(breed.likedPhotos.count) photo"
        if breed.likedPhotos.count > 1{
            cell.nameLabel.text! += "s)"
        }
        else{
            cell.nameLabel.text! += ")"
        }
            return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favBreeds.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowFavBreedDetails", sender: indexPath)
        }

}

