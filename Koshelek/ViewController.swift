//
//  ViewController.swift
//  Koshelek
//
//  Created by Berezkin on 28.08.2020.
//  Copyright © 2020 Berezerker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var allBreeds: breedList?
    @IBOutlet weak var breedsTable: UITableView!
    let loader = Loader()
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.loadBreeds { breeds in
            self.allBreeds = breeds
            self.breedsTable.delegate = self
            self.breedsTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailsViewController, segue.identifier == "ShowBreedDetails"{
            let position = sender as! IndexPath
            vc.breed = allBreeds!.breeds[position.row]
        }
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedCell") as! BreedCell
        let breed = allBreeds!.breeds[indexPath.row]
        cell.nameLabel.text = "\(breed.name!)"
        if breed.types!.count > 0{
            cell.nameLabel.text! += " (\(breed.types!.count))"
        }
            return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allBreeds == nil{
            return 0
    }
        return allBreeds!.breeds.count
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        if allBreeds!.breeds[indexPath.row].types!.count == 0{
            performSegue(withIdentifier: "ShowBreedDetails", sender: indexPath)
        }
        else{
            
        }
    }

}
