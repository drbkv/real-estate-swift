//////import Foundation
//////import FirebaseDatabase
//////import FirebaseStorage
//////
//////class UserListingManager {
//////    static let shared = UserListingManager()
//////    
//////    private let databaseReference = Database.database().reference()
//////    
//////    private init() {}
//////    
//////    func getUserListings(completion: @escaping () -> Void) {
//////        guard let userId = UserManager.shared.userId else {
//////            print("User ID not found")
//////            completion()
//////            return
//////        }
//////
//////        databaseReference.child("listings").child(userId).observeSingleEvent(of: .value) { snapshot in
//////            guard let value = snapshot.value as? [String: Any] else {
//////                print("No listings found for user ID: \(userId)")
//////                completion()
//////                return
//////            }
//////
//////            let listings = value.compactMap { (_, listingData) -> RealEstateListing? in
//////                guard let listingData = listingData as? [String: Any] else { return nil }
//////                return RealEstateListing(
//////                    userId: userId,
//////                    type: .sale, // Assuming you have a default value or a way to determine the type
//////                    propertyType: .apartment, // Assuming you have a default value or a way to determine the property type
//////                    price: listingData["price"] as? Int ?? 0,
//////                    numberOfRooms: listingData["numberOfRooms"] as? Int ?? 0,
//////                    area: listingData["area"] as? Int ?? 0,
//////                    photoURL: listingData["photoURL"] as? String ?? "",
//////                    description: listingData["description"] as? String ?? "",
//////                    address: listingData["address"] as? String ?? ""
//////                )
//////            }
//////
//////            // Handle the user listings, for example, save them to a property in UserManager
//////            // UserManager.shared.userListings = listings
//////            print("User listings loaded successfully")
//////            completion()
//////        }
//////    }
//////}
////
////
//
//import Foundation
//import FirebaseDatabase
//import FirebaseStorage
//
//class UserListingManager {
//    static let shared = UserListingManager()
//    
//    private let databaseReference = Database.database().reference()
//    
//    private init() {}
//    
//    func getUserListings(completion: @escaping ([RealEstateListing]) -> Void) {
//        guard let userId = UserManager.shared.userId else {
//            print("User ID not found")
//            completion([])
//            return
//        }
//
//        databaseReference.child("listings").child(userId).observeSingleEvent(of: .value) { snapshot in
//            guard let value = snapshot.value as? [String: Any] else {
//                print("No listings found for user ID: \(userId)")
//                completion([])
//                return
//            }
//
//            let listings = value.compactMap { (_, listingData) -> RealEstateListing? in
//                guard let listingData = listingData as? [String: Any] else { return nil }
//                let listing = RealEstateListing(
//                    userId: userId,
//                    type: .sale,
//                    propertyType: .apartment,
//                    price: listingData["price"] as? Int ?? 0,
//                    numberOfRooms: listingData["numberOfRooms"] as? Int ?? 0,
//                    area: listingData["area"] as? Int ?? 0,
//                    photoURL: listingData["photoURL"] as? String ?? "",
//                    description: listingData["description"] as? String ?? "",
//                    address: listingData["address"] as? String ?? ""
//                )
//                print("Listing loaded: \(listing)")
//                return listing
//            }
//
//            print("Listings count: \(listings.count)")
//            print("Listings: \(listings)")
//            completion(listings)
//        }
//    }
//
//}
