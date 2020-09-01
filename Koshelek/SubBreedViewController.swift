//
//  SubBreedViewController.swift
//  Koshelek
//
//  Created by Berezkin on 28.08.2020.
//  Copyright © 2020 Berezerker. All rights reserved.
//

import UIKit

class SubBreedViewController: UIViewController {
    var allBreeds: [String]?
    var mainBreedName = ""
    @IBOutlet weak var breedsTable: UITableView!
    let loader = Loader()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        breedsTable.delegate = self
        breedsTable.dataSource = self
        breedsTable.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailsViewController, segue.identifier == "ShowSubBreedDetails"{
            let position = sender as! IndexPath
            let chosenBreed = Breed(name: allBreeds![position.row], types: [], likedImages: [])
            vc.breed = chosenBreed
            vc.mainName = mainBreedName
        }
    }

}

extension SubBreedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubBreedCell") as! SubBreedCell
        let breed = allBreeds![indexPath.row]
        cell.nameLabel.text = "\(breed)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allBreeds == nil{
            return 0
    }
        return allBreeds!.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowSubBreedDetails", sender: indexPath)
    }
    
}

