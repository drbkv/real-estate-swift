import Foundation
import UIKit
import Firebase

struct RealEstateListing {
    let userId: String
    let type: ListingType
    let propertyType: PropertyType
    let price: Int
    let numberOfRooms: Int
    let area: Int
    let photoURL: String
    let description: String
    let address: String
}

enum ListingType {
    case sale
    case rent
}

enum PropertyType {
    case apartment
    case house
    case other
}

