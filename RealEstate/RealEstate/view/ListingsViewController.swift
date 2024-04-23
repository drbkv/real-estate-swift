//import UIKit
//import Firebase
//
//class ListingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var listings: [RealEstateListing] = []
//    let tableView = UITableView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Listings"
//        view.addSubview(tableView)
//        tableView.frame = view.bounds
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        fetchListings()
//    }
//
//    func fetchListings() {
//        let ref = Database.database().reference(fromURL: "https://realestate-eb7db-default-rtdb.firebaseio.com/")
//        ref.child("listings").observe(.value, with: { snapshot in
//            guard let value = snapshot.value as? [String: Any] else { return }
//            var newlistings: [RealEstateListing] = []
//            for child in value {
//                if let listingDict = child.value as? [String: Any], let listing = RealEstateListing(snapshot: listingDict) {
//                    newlistings.append(listing)
//                }
//            }
//            self.listings = newlistings
//            self.tableView.reloadData()
//        })
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listings.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
//        let listing = listings[indexPath.row]
//        cell.textLabel?.text = listing.type.rawValue + " " + listing.propertyType.rawValue
//        cell.detailTextLabel?.text = "Price: \(listing.price), Rooms: \(listing.numberOfRooms), Building: \(listing.buildingType.rawValue)"
//        return cell
//    }
//}
