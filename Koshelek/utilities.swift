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
    var breeds: [Breed]
}
