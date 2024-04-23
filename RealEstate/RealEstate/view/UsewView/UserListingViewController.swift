import UIKit
import Firebase
import SDWebImage

class UserListingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let databaseReference = Database.database().reference(fromURL: "https://realestate-eb7db-default-rtdb.firebaseio.com/")
    private var userListingIds: [String] = []
    private var userListingData: [RealEstateListing] = []

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Get the current user's UID
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User ID not found")
            return
        }

        let userListingRef = databaseReference.child("listings").queryOrdered(byChild: "userId").queryEqual(toValue: userId)
        userListingRef.observe(.value) { snapshot in
            guard let snapshots = snapshot.children.allObjects as? [DataSnapshot] else {
                print("No user listings found")
                return
            }

            self.userListingData.removeAll()
            self.userListingIds.removeAll()

            for snap in snapshots {
                guard let dict = snap.value as? [String: Any] else {
                    continue
                }

                let listingId = snap.key
                let type = dict["type"] as? String ?? ""
                let propertyTypeString = dict["propertyType"] as? String ?? ""
                let price = dict["price"] as? Int ?? 0
                let numberOfRooms = dict["numberOfRooms"] as? Int ?? 0
                let area = dict["area"] as? Int ?? 0
                let photoURL = dict["photoURL"] as? String ?? ""
                let description = dict["description"] as? String ?? ""
                let address = dict["address"] as? String ?? ""

                let propertyType: PropertyType
                switch propertyTypeString {
                case "apartment":
                    propertyType = .apartment
                case "house":
                    propertyType = .house
                default:
                    propertyType = .other
                }

                let listing = RealEstateListing(userId: userId, type: type == "sale" ? .sale : .rent, propertyType: propertyType, price: price, numberOfRooms: numberOfRooms, area: area, photoURL: photoURL, description: description, address: address)

                self.userListingIds.append(listingId)
                self.userListingData.append(listing)
            }

            self.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListingData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let listing = userListingData[indexPath.row]

        // Создаем контейнер для фото и информации
        let containerStackView = UIStackView()
        containerStackView.axis = .horizontal
        containerStackView.spacing = 8
        containerStackView.alignment = .center
        cell.contentView.addSubview(containerStackView)
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8),
            containerStackView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 4),
            containerStackView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -8),
            containerStackView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -4)
        ])

        // Setup imageView with first photoURL
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        if let firstPhotoUrl = listing.photoURL.split(separator: ",").first {
            imageView.sd_setImage(with: URL(string: String(firstPhotoUrl.trimmingCharacters(in: .whitespaces))), completed: nil)
        }
        containerStackView.addArrangedSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.4), // Уменьшаем ширину в 2.5 раза
            imageView.heightAnchor.constraint(equalToConstant: 100) // Устанавливаем фиксированную высоту
        ])

        // Создаем стек для информации справа от фото
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.spacing = 4
        containerStackView.addArrangedSubview(infoStackView)

        let typeLabel = UILabel()
        typeLabel.text = listing.type == .sale ? "For Sale" : "For Rent"
        typeLabel.font = UIFont.systemFont(ofSize: 18) // Уменьшаем размер шрифта
        infoStackView.addArrangedSubview(typeLabel)

        let propertyTypeLabel = UILabel()
        propertyTypeLabel.text = "\(listing.propertyType)"
        propertyTypeLabel.font = UIFont.systemFont(ofSize: 18) // Уменьшаем размер шрифта
        infoStackView.addArrangedSubview(propertyTypeLabel)

        let priceLabel = UILabel()
        priceLabel.text = "Price: \(listing.price)"
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20) // Устанавливаем
        infoStackView.addArrangedSubview(priceLabel)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = UserListingsDetailViewController()
        detailViewController.listing = userListingData[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }

}
