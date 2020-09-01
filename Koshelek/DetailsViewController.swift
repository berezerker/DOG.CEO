//
//  DetailsViewController.swift
//  Koshelek
//
//  Created by Berezkin on 28.08.2020.
//  Copyright © 2020 Berezerker. All rights reserved.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController {

    @IBAction func ShareTapped(_ sender: Any) {
        let shareAl = shareAlert()
        present(shareAl, animated: true)
        }
    var mainName = ""
    @IBAction func next(_ sender: UISwipeGestureRecognizer) {
        next(&i)
        image.loadImageWithURL(url: imageURLs[i])
        if isLiked(breed!.name!, photo: imageURLs[i]){
            likeForm.setBackgroundImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        }
        else{
        likeForm.setBackgroundImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
    }
    @IBAction func back(_ sender: UISwipeGestureRecognizer) {
        back(&i)
        image.loadImageWithURL(url: imageURLs[i])
        if isLiked(breed!.name!, photo: imageURLs[i]){
            likeForm.setBackgroundImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        }
        else{
        likeForm.setBackgroundImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
    }
    
    @IBOutlet weak var likeForm: UIButton!
    @IBAction func likeButton(_ sender: Any) {
        Persistance.shared.addPhoto(breed!, photo: imageURLs[i])
        likeForm.setBackgroundImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
    }
    @IBOutlet weak var image: UIImageView!
    var i = 0
    var breed: Breed?
    var imageURLs: [String] = []
    let loader = Loader()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        image.isUserInteractionEnabled = true
               self.title = breed!.name!
               loader.loadImages( breed!.name!, mainName, completion: { urls, successful, error  in
                    if successful{
                        self.imageURLs = urls!
                        self.image.loadImageWithURL(url: self.imageURLs[self.i])
                    }
                    else{
                        self.showAlert(error!)
                }
               })
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainName = ""
    }
    
    func next(_ i: inout Int){
        if i == imageURLs.count - 1{
            i = 0
    }
        else{
            i += 1
        }
    }
    
    func back(_ i: inout Int){
        if i == 0{
            i = imageURLs.count - 1
    }
        else{
            i -= 1
        }
    }

}


