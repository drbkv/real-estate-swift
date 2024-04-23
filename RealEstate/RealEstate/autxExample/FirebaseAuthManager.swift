//import UIKit
//import Alamofire
//import Firebase
//
//class FirebaseAuthManager {
//    static let shared = FirebaseAuthManager()
//    private init() {}
//
//    func registerUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
//        let parameters: [String: Any] = [
//            "email": email,
//            "password": password,
//            "returnSecureToken": true
//        ]
//
//        let url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB2PA5Wye07K0h4SiTh2hkAXpxEm5zQcTA"
//
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    print(value)
//                    completion(nil)
//                case .failure(let error):
//                    print(error)
//                    completion(error)
//                }
//            }
//    }
//
//    func loginUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
//        let parameters: [String: Any] = [
//            "email": email,
//            "password": password,
//            "returnSecureToken": true
//        ]
//
//        let url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyB2PA5Wye07K0h4SiTh2hkAXpxEm5zQcTA"
//
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    print(value)
//                    completion(nil)
//                case .failure(let error):
//                    print(error)
//                    completion(error)
//                }
//            }
//    }
//}
