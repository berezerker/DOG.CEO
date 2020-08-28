//
//  DetailsViewController.swift
//  Koshelek
//
//  Created by Berezkin on 28.08.2020.
//  Copyright © 2020 Berezerker. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBAction func next(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right{
            i += 1
            image.loadImageWithURL(url: imageURLs[i])
        }
    }
    @IBAction func likeButton(_ sender: Any) {
    }
    @IBOutlet weak var image: UIImageView!
    var i = 0
    var breed: Breed?
    var imageURLs: [String] = []
    let loader = Loader()
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.loadImages(breed: breed!.name!, completion: { urls in
            self.imageURLs = urls!
        })
        image.loadImageWithURL(url: imageURLs[i])
    }
    
    func next(_ i: Int){
        if i == imageURLs.count - 1{
            self.i = 0
    }
        else{
            self.i += 1
        }
    }
    
    func back(_ i: Int){
        if i == 0{
            self.i = imageURLs.count - 1
    }
        else{
            self.i -= 1
        }
    }

}

