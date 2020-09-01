//
//  utilities.swift
//  Koshelek
//
//  Created by Berezkin on 28.08.2020.
//  Copyright © 2020 Berezerker. All rights reserved.
//

import Foundation
import UIKit

struct breedList{
    var breeds: [Breed]

}


struct Breed{
    let name: String?
    var types: [String]?
    var likedImages: [String]?
}

struct Favourites{
    var breeds: [Breed]?
}

func isLiked(_ name: String, photo: String) -> Bool{
    let FavouriteBreeds = Persistance.shared.allBreeds()
    var isIn = false
    for el in FavouriteBreeds{
        if el.name == name{
            for likedPhoto in el.likedPhotos{
                if photo == likedPhoto{
                    isIn = true
                }
            }
        }
    }
    return isIn
}


func shareAlert() -> UIAlertController{
    let alert = UIAlertController()
    alert.addAction(UIAlertAction(title: "Share", style: .default) { (action: UIAlertAction) in
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (action: UIAlertAction) in
            alert.dismiss(animated: true)
        })
        return alert
    }
