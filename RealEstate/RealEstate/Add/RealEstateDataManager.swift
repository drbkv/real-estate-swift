    import Foundation
    import Firebase
    import FirebaseStorage

    class RealEstateDataManager {
        private let databaseReference = Database.database().reference(fromURL: "https://realestate-eb7db-default-rtdb.firebaseio.com/")
        private let storageReference = Storage.storage().reference(forURL: "gs://realestate-eb7db.appspot.com")
        
        func addListing(listing: RealEstateListing, completion: @escaping (Error?) -> Void) {
            let listingsReference = databaseReference.child("listings").childByAutoId()
            let listingData: [String: Any] = [
                "userId": listing.userId,
                "type": listing.type == .sale ? "sale" : "rent",
                "propertyType": propertyTypeToString(listing.propertyType),
                "price": listing.price,
                "numberOfRooms": listing.numberOfRooms,
                "area": listing.area,
                "photoURL": listing.photoURL,
                "description": listing.description,
                "address": listing.address
            ]

            
            listingsReference.setValue(listingData) { error, _ in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        }
        
        private func propertyTypeToString(_ propertyType: PropertyType) -> String {
            switch propertyType {
            case .apartment:
                return "apartment"
            case .house:
                return "house"
            case .other:
                return "other"
            }
        }
    }




