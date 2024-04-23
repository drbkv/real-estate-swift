//
//  Listing.swift
//  RealEstate
//
//  Created by Ramzan on 22.04.2024.
//

import Foundation
import Firebase
import FirebaseStorage

struct Listing {
    let userId: String
    let type: ListingType
    let category: ListingCategory
    let price: Int
    let rooms: Int
    let area: Int
    var photos: [UIImage]
}

enum ListingType {
    case sale
    case rent
}

enum ListingCategory {
    case apartment
    case house
    case other
}
