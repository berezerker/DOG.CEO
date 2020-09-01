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
    func loadBreeds(completion: @escaping (breedList?, Bool, String?) -> Void) {
        var loadedBreeds = breedList(breeds: [])
        var errorMessage = ""
        var successful = false
        let url = URL(string: "https://dog.ceo/api/breeds/list/all")!
        AF.request(url).responseJSON{ response in
            print("HI")
                switch response.result{
                case .success(let value):
                    if let json = value as? [String: Any] {
                        let list = json["message"] as? [String: Any]
                        for el in list!{
                            let breed = Breed(name: el.key, types: el.value as? [String])
                            loadedBreeds.breeds.append(breed)
                        }
                        errorMessage = "successful"
                        successful = true
                        }
                    DispatchQueue.main.async {
                        completion(loadedBreeds, successful, errorMessage)
                    }
                case .failure:
                    print("error")
                    errorMessage = "Request unsuccessful"
                    successful = false
                    DispatchQueue.main.async {
                        completion(loadedBreeds, successful, errorMessage)
                    }
                    }
        }
    }
    
    func loadImages(_ breed: String,_ mainName: String, completion: @escaping ([String]?, Bool, String?) -> Void) {
        var loadedImages: [String] = []
        var errorMessage = ""
        var url: URL?
        if mainName == ""{
        url = URL(string: "https://dog.ceo/api/breed/\(breed)/images")!
        }
        else{
            url = URL(string: "https://dog.ceo/api/breed/\(mainName)/\(breed)/images")!
        }
        AF.request(url!).responseJSON{ response in
                switch response.result{
                case .success(let value):
                    if let json = value as? [String: Any] {
                        let list = json["message"] as? [String]
                        for el in list!{
                            loadedImages.append(el)
                        }
                        }
                    errorMessage = "successful"
                    DispatchQueue.main.async {
                        completion(loadedImages, true, errorMessage)
                    }
                    case .failure:
                        DispatchQueue.main.async {
                            completion(loadedImages, false, "Connection lost")
                        }
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
        }
        
        if let urlFinal = URL(string: url) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: urlFinal) { (data, response, error) in
                if let unwrappedError = error {
                    print(unwrappedError)
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


