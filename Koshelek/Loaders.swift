//
//  Loaders.swift
//  Koshelek
//
//  Created by Berezkin on 28.08.2020.
//  Copyright © 2020 Berezerker. All rights reserved.
//

import Foundation
import Alamofire
import UIKit


class Loader{
    func loadBreeds(completion: @escaping (breedList?) -> Void) {
        var loadedBreeds = breedList(breeds: [])
        let url = URL(string: "https://dog.ceo/api/breeds/list/all")!
        AF.request(url).responseJSON{ response in
                switch response.result{
                case .success(let value):
                    if let json = value as? [String: Any] {
                        let list = json["message"] as? [String: Any]
                        for el in list!{
                            let breed = Breed(name: el.key, types: el.value as? [String])
                            loadedBreeds.breeds.append(breed)
                        }
                        }
                    case .failure(let error):
                        print(error)
                    }
            DispatchQueue.main.async {
                completion(loadedBreeds)
            }
        }
    }
    
    func loadImages( breed: String, completion: @escaping ([String]?) -> Void) {
        var loadedImages: [String] = []
        print(breed)
        let url = URL(string: "https://dog.ceo/api/breed/hound/images")!
        print(url)
        AF.request(url).responseJSON{ response in
                switch response.result{
                case .success(let value):
                    if let json = value as? [String: Any] {
                        let list = json["message"] as? [String: Any]
                        print(list!.keys)
                        for el in list!{
                            print(el.key)
                            loadedImages.append(el.key)
                        }
                        }
                    case .failure(let error):
                        print(error)
                    }
            DispatchQueue.main.async {
                completion(loadedImages)
            }
        }
    }
}

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageWithURL(url: String) {
        
        image = nil
    
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            image = cachedImage
            return
        }
        
        if let urlFinal = URL(string: url) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: urlFinal) { (data, response, error) in
                if let unwrappedError = error {
                    print(unwrappedError)
                    return
                }
                
                if let unwrappedData = data, let downloadedImage = UIImage(data: unwrappedData) {
                    DispatchQueue.main.async(execute: {
                        imageCache.setObject(downloadedImage, forKey: url as NSString)
                        self.image = downloadedImage
                    })
                }
                
            }
            dataTask.resume()
        }
    }
}


