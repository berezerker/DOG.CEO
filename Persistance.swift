//
//  Persistance.swift
//  Koshelek
//
//  Created by Berezkin on 29.08.2020.
//  Copyright © 2020 Berezerker. All rights reserved.
//

import Foundation

import RealmSwift

class FavBreed: Object{
    @objc dynamic var name: String = ""
    var likedPhotos = List<String>()
    

}

class Persistance{
    static let shared = Persistance()
    
    private let realm = try! Realm()
    
    func allBreeds() -> Results<FavBreed>{
        let allBreeds = realm.objects(FavBreed.self)
        return allBreeds
    }
    
    func addPhoto(_ breed: Breed, photo: String){
        let all = Persistance.shared.allBreeds()
        for el in all{
            if el.name == breed.name!{
                let toUpdate = realm.objects(FavBreed.self).filter("name = %@", breed.name!)
                if let toUpdateFirst = toUpdate.first{
                    if !(toUpdateFirst.likedPhotos.contains(photo)){
                        try! realm.write(){
                        toUpdateFirst.likedPhotos.append(photo)
                        }
                    }
                }
                return
            }
        }
        try! realm.write(){
            let new = FavBreed()
            new.name = breed.name!
            new.likedPhotos.append(photo)
            realm.add(new)
        }
    }
    func deletePhoto(_ breed: FavBreed, photo: String){
        let toUpdate = realm.objects(FavBreed.self).filter("name = %@", breed.name)
        if let toUpdateFirst = toUpdate.first{
            try! realm.write(){
                if let index = toUpdateFirst.likedPhotos.index(of: photo){
                    toUpdateFirst.likedPhotos.remove(at: index)
                }
                }
                
            }
        }
    
    func clear(){
        try! realm.write(){
            for el in realm.objects(FavBreed.self){
                if el.likedPhotos.count == 0{
                    realm.delete(el)
                }
            }
        }
    }
    }
