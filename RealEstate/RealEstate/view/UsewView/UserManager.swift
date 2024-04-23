//////import FirebaseAuth
//////import FirebaseDatabase
//////import FirebaseStorage
//////
//////class UserManager {
//////    static let shared = UserManager()
//////    
//////    var userId: String?
//////    
//////    private init() {
//////        observeAuthChanges()
//////    }
//////    
//////    private func observeAuthChanges() {
//////        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
//////            guard let userId = user?.uid else { return }
//////            self?.userId = userId
//////            // Call getUserListings here
//////            UserListingManager.shared.getUserListings { _ in }
//////            let databaseReference = Database.database().reference(fromURL: "https://realestate-eb7db-default-rtdb.firebaseio.com/")
//////            databaseReference.child("users").child(userId).observeSingleEvent(of: .value) { snapshot in
//////                if snapshot.exists() {
//////                    print("User data found in the database")
//////                } else {
//////                    print("User data not found in the database")
//////                }
//////            }
//////        }
//////    }
//////
//////}
////
//
//
//
//import FirebaseAuth
//import FirebaseDatabase
//import FirebaseStorage
//
//class UserManager {
//    static let shared = UserManager()
//    
//    var userId: String?
//    
//    private init() {
//        observeAuthChanges()
//    }
//    
//    private func observeAuthChanges() {
//        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
//            guard let userId = user?.uid else { return }
//            self?.userId = userId
//            let databaseReference = Database.database().reference(fromURL: "https://realestate-eb7db-default-rtdb.firebaseio.com/")
//            databaseReference.child("users").child(userId).observeSingleEvent(of: .value) { snapshot in
//                if snapshot.exists() {
//                    print("User data found in the database")
//                    UserListingManager.shared.getUserListings {
//                        print("User listings loaded successfully")
//                    }
//                } else {
//                    print("User data not found in the database")
//                }
//            }
//        }
//    }
//
//
//}
