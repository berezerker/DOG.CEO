//
//  ViewController.swift
//  Koshelek
//
//  Created by Berezkin on 28.08.2020.
//  Copyright © 2020 Berezerker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var indicator = UIActivityIndicatorView()

    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    var allBreeds: breedList?
    @IBOutlet weak var breedsTable: UITableView!
    let loader = Loader()
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator()
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loader.loadBreeds { breeds, successful, error in
            if successful{
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                self.allBreeds = breeds
                self.breedsTable.delegate = self
                self.breedsTable.reloadData()
            }
            else{
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                print(successful)
                self.showAlert(error!)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailsViewController, segue.identifier == "ShowBreedDetails"{
            let position = sender as! IndexPath
            vc.breed = allBreeds!.breeds[position.row]
        }
        if let vc = segue.destination as? SubBreedViewController, segue.identifier == "ShowSubBreeds"{
            let position = sender as! IndexPath
            vc.allBreeds = allBreeds!.breeds[position.row].types!
            vc.mainBreedName = allBreeds!.breeds[position.row].name!
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if allBreeds!.breeds[indexPath.row].types!.count == 0{
            performSegue(withIdentifier: "ShowBreedDetails", sender: indexPath)
        }
        else{
            performSegue(withIdentifier: "ShowSubBreeds", sender: indexPath)
        }
    }

}
