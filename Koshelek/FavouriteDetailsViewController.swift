//
//  FavouriteDetailsViewController.swift
//  Koshelek
//
//  Created by Berezkin on 30.08.2020.
//  Copyright © 2020 Berezerker. All rights reserved.
//

import UIKit
import RealmSwift

class FavouriteDetailsViewController: UIViewController {
    var breed: FavBreed?
    var photosToDelete: [String] = []
    @IBOutlet weak var image: UIImageView!
    var i = 0
    
    @IBAction func ShareTapped(_ sender: Any) {
        let shareAl = shareAlert()
        present(shareAl, animated: true)
    }
    
    @IBOutlet weak var button: UIButton!
    @IBAction func likeButton(_ sender: Any) {
        photosToDelete.append(breed!.likedPhotos[i])
        button.setBackgroundImage(UIImage(systemName: "suit.heart"), for: .normal)
    }
    @IBAction func next(_ sender: UISwipeGestureRecognizer) {
        next(&i)
        image.loadImageWithURL(url: breed!.likedPhotos[i])
        if !(photosToDelete.contains(breed!.likedPhotos[i])){
        button.setBackgroundImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        }
        else{
            button.setBackgroundImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
    }
    @IBAction func back(_ sender: UISwipeGestureRecognizer) {
        back(&i)
        image.loadImageWithURL(url: breed!.likedPhotos[i])
        if !(photosToDelete.contains(breed!.likedPhotos[i])){
        button.setBackgroundImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        }
        else{
            button.setBackgroundImage(UIImage(systemName: "suit.heart"), for: .normal)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.isUserInteractionEnabled = true
        image.loadImageWithURL(url: breed!.likedPhotos[i])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for el in photosToDelete{
            print("deleting photo \(el)")
        Persistance.shared.deletePhoto(breed!, photo: el)
        }
        photosToDelete = []
    }
    
    
    
    func next(_ i: inout Int){
        if i == breed!.likedPhotos.count - 1{
            i = 0
    }
        else{
            i += 1
        }
    }
    
    func back(_ i: inout Int){
        if i == 0{
            i = breed!.likedPhotos.count - 1
    }
        else{
            i -= 1
        }
    }
    
}
