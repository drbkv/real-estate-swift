////
////  RealEstateDataManager.swift
////  RealEstate
////
////  Created by Ramzan on 23.04.2024.
////
//// RealEstateViewDataManager.swift
//import Foundation
//import Firebase
//import FirebaseStorage
//import UIKit
//
//class RealEstateViewDataManager {
//    static let shared = RealEstateViewDataManager()
//    private let databaseReference = Database.database().reference(fromURL: "https://realestate-eb7db-default-rtdb.firebaseio.com/")
//
//    // MARK: - Edit Listing
//    func editListing(listingId: String, newData: [String: Any], completion: @escaping (Error?) -> Void) {
//        let listingRef = databaseReference.child("listings").child(listingId)
//        listingRef.updateChildValues(newData) { error, _ in
//            completion(error)
//        }
//    }
//
//    // MARK: - Delete Listing
//    func deleteListing(listingId: String, completion: @escaping (Error?) -> Void) {
//        let listingRef = databaseReference.child("listings").child(listingId)
//        listingRef.removeValue { error, _ in
//            completion(error)
//        }
//    }
//}
