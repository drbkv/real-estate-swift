////
////  userAll.swift
////  RealEstate
////
////  Created by Ramzan on 22.04.2024.
////
//import Foundation
//import UIKit
//
//class UserAllViewController: UIViewController {
//    
//    let userListingManager = UserListingManager.shared
//    let userListingsViewController = UserListingsViewController()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Ваша логика инициализации и отображения UserListingsViewController
//        showUserListingsViewController()
//    }
//    
//    func showUserListingsViewController() {
//        userListingManager.getUserListings { [weak self] in
//            DispatchQueue.main.async {
//                self?.navigationController?.pushViewController(self!.userListingsViewController, animated: true)
//            }
//        }
//    }
//}
