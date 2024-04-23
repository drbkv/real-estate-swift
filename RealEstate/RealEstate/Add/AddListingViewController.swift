//import UIKit
//import ImageSlideshow
//import Firebase
//import FirebaseStorage
//
//class AddListingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    private let dataManager = RealEstateDataManager()
//    private var userId: String?
//
//    private lazy var slideshow: ImageSlideshow = {
//        let slideshow = ImageSlideshow()
//        slideshow.backgroundColor = .lightGray
//        slideshow.contentScaleMode = .scaleAspectFill
//        slideshow.clipsToBounds = true
//        slideshow.activityIndicator = DefaultActivityIndicator()
//        slideshow.slideshowInterval = 0
//        return slideshow
//    }()
//
//    private lazy var typeSegmentedControl: UISegmentedControl = {
//        let segmentedControl = UISegmentedControl(items: ["Sale", "Rent"])
//        segmentedControl.selectedSegmentIndex = 0
//        return segmentedControl
//    }()
//
//    private lazy var propertyTypeSegmentedControl: UISegmentedControl = {
//        let segmentedControl = UISegmentedControl(items: ["Apartment", "House", "Other"])
//        segmentedControl.selectedSegmentIndex = 0
//        return segmentedControl
//    }()
//
//    private lazy var priceTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Price"
//        textField.keyboardType = .numberPad
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private lazy var numberOfRoomsTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Number of Rooms"
//        textField.keyboardType = .numberPad
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private lazy var descriptionTextView: UITextView = {
//        let textView = UITextView()
//        textView.text = "Description"
//        textView.textColor = .lightGray
//        textView.layer.borderColor = UIColor.lightGray.cgColor
//        textView.layer.borderWidth = 1.0
//        textView.layer.cornerRadius = 5.0
//        return textView
//    }()
//
//    private lazy var addressTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Address"
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private lazy var areaTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Area (sq. m)"
//        textField.keyboardType = .numberPad
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private lazy var addPhotoButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Add Photo", for: .normal)
//        button.backgroundColor = .gray
//        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var addButton: UIButton = {
//        let button = UIButton()
//        let plusImage = UIImage(systemName: "plus.circle.fill")
//        button.setImage(plusImage, for: .normal)
//        button.tintColor = .green
//        button.addTarget(self, action: #selector(addListing), for: .touchUpInside)
//
//        let scale: CGFloat = 2.5
//        button.transform = CGAffineTransform(scaleX: scale, y: scale)
//
//        return button
//    }()
//
//    private var imageSources: [UIImage] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//
//        view.addSubview(slideshow)
//        view.addSubview(typeSegmentedControl)
//        view.addSubview(propertyTypeSegmentedControl)
//        view.addSubview(priceTextField)
//        view.addSubview(numberOfRoomsTextField)
//        view.addSubview(areaTextField)
//        view.addSubview(addressTextField)
//        view.addSubview(descriptionTextView)
//        view.addSubview(addPhotoButton)
//        view.addSubview(addButton)
//
//        slideshow.translatesAutoresizingMaskIntoConstraints = false
//        typeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        propertyTypeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        priceTextField.translatesAutoresizingMaskIntoConstraints = false
//        numberOfRoomsTextField.translatesAutoresizingMaskIntoConstraints = false
//        areaTextField.translatesAutoresizingMaskIntoConstraints = false
//        addressTextField.translatesAutoresizingMaskIntoConstraints = false
//        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
//        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
//        addButton.translatesAutoresizingMaskIntoConstraints = false
//        
//
//        
//        NSLayoutConstraint.activate([
//            slideshow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            slideshow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            slideshow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            slideshow.heightAnchor.constraint(equalToConstant: 200),
//            
//            typeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            typeSegmentedControl.centerYAnchor.constraint(equalTo: slideshow.bottomAnchor, constant: 20),
//            
//            propertyTypeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            propertyTypeSegmentedControl.centerYAnchor.constraint(equalTo: typeSegmentedControl.bottomAnchor, constant: 20),
//            
//            priceTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            priceTextField.centerYAnchor.constraint(equalTo: propertyTypeSegmentedControl.bottomAnchor, constant: 20),
//            
//            numberOfRoomsTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            numberOfRoomsTextField.centerYAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 20),
//            
//            areaTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            areaTextField.centerYAnchor.constraint(equalTo: numberOfRoomsTextField.bottomAnchor, constant: 20),
//
//            addressTextField.topAnchor.constraint(equalTo: areaTextField.bottomAnchor, constant: 20),
//               addressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//               addressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//               addressTextField.heightAnchor.constraint(equalToConstant: 20),
//            
//            // Constraints for descriptionTextView
//                descriptionTextView.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
//                descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//                descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//                descriptionTextView.heightAnchor.constraint(equalToConstant: 40),
//            
//            
////
//           
//            
//            addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//               addPhotoButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
//
//               addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//               addButton.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 20),
//            
//        ])
//
//        // Get the current user's UID
//        if let uid = Auth.auth().currentUser?.uid {
//            userId = uid
//        }
//    }
//
//    @objc private func addPhoto() {
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.delegate = self
//        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.allowsEditing = false
//        present(imagePickerController, animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[.originalImage] as? UIImage {
//            imageSources.append(image)
//            slideshow.setImageInputs(imageSources.map { ImageSource(image: $0) })
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    private func clearPhotos() {
//        imageSources.removeAll()
//        slideshow.setImageInputs([])
//    }
//
//    @objc private func addListing() {
//        guard let userId = userId else {
//            print("User ID not found")
//            return
//        }
//
//        guard let priceText = priceTextField.text, !priceText.isEmpty,
//              let roomsText = numberOfRoomsTextField.text, !roomsText.isEmpty,
//              let areaText = areaTextField.text, !areaText.isEmpty,
//              let addressText = addressTextField.text, !addressText.isEmpty,
//              let descriptionText = descriptionTextView.text, !descriptionText.isEmpty else {
//                  let alertController = UIAlertController(title: "Warning", message: "Please fill in all fields", preferredStyle: .alert)
//                  alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                  present(alertController, animated: true, completion: nil)
//                  return
//        }
//
//        var photoURLs: [String] = []
//        let group = DispatchGroup()
//        for image in imageSources {
//            group.enter()
//            let storageRef = Storage.storage().reference().child("photos/\(UUID().uuidString).jpg")
//            if let uploadData = image.jpegData(compressionQuality: 0.5) {
//                storageRef.putData(uploadData, metadata: nil) { metadata, error in
//                    if let error = error {
//                        print("Error uploading photo: \(error.localizedDescription)")
//                        group.leave()
//                        return
//                    }
//                    storageRef.downloadURL { url, error in
//                        if let error = error {
//                            print("Error getting download URL: \(error.localizedDescription)")
//                            group.leave()
//                            return
//                        }
//                        if let downloadURL = url?.absoluteString {
//                            photoURLs.append(downloadURL)
//                        }
//                        group.leave()
//                    }
//                }
//            } else {
//                group.leave()
//            }
//        }
//
//        group.notify(queue: .main) {
//            let listing = RealEstateListing(
//                userId: userId,
//                type: self.typeSegmentedControl.selectedSegmentIndex == 0 ? .sale : .rent,
//                propertyType: self.propertyTypeSegmentedControl.selectedSegmentIndex == 0 ? .apartment : (self.propertyTypeSegmentedControl.selectedSegmentIndex == 1 ? .house : .other),
//                price: Int(priceText) ?? 0,
//                numberOfRooms: Int(roomsText) ?? 0,
//                area: Int(areaText) ?? 0,
//                photoURL: photoURLs.joined(separator: ", "),
//                description: descriptionText,
//                address: addressText
//            )
//
//            self.dataManager.addListing(listing: listing) { error in
//                if let error = error {
//                    print("Error adding listing: \(error.localizedDescription)")
//                } else {
//                    print("Listing added successfully")
//                    self.priceTextField.text = ""
//                    self.numberOfRoomsTextField.text = ""
//                    self.areaTextField.text = ""
//                    self.clearPhotos()
//                }
//            }
//        }
//    }
//}
//
//
//
//


//
//import UIKit
//import ImageSlideshow
//import Firebase
//import FirebaseStorage
//
//class AddListingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    private let dataManager = RealEstateDataManager()
//    private var userId: String?
//
//    private lazy var slideshow: ImageSlideshow = {
//        let slideshow = ImageSlideshow()
//        slideshow.backgroundColor = .lightGray
//        slideshow.contentScaleMode = .scaleAspectFill
//        slideshow.clipsToBounds = true
//        slideshow.activityIndicator = DefaultActivityIndicator()
//        slideshow.slideshowInterval = 0
//        return slideshow
//    }()
//
//    private lazy var typeSegmentedControl: UISegmentedControl = {
//        let segmentedControl = UISegmentedControl(items: ["Sale", "Rent"])
//        segmentedControl.selectedSegmentIndex = 0
//        return segmentedControl
//    }()
//
//    private lazy var propertyTypeSegmentedControl: UISegmentedControl = {
//        let segmentedControl = UISegmentedControl(items: ["Apartment", "House", "Other"])
//        segmentedControl.selectedSegmentIndex = 0
//        return segmentedControl
//    }()
//
//    private lazy var priceTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Price"
//        textField.keyboardType = .numberPad
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private lazy var numberOfRoomsTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Number of Rooms"
//        textField.keyboardType = .numberPad
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private lazy var descriptionTextView: UITextView = {
//        let textView = UITextView()
//        textView.text = "Description"
//        textView.textColor = .lightGray
//        textView.layer.borderColor = UIColor.lightGray.cgColor
//        textView.layer.borderWidth = 1.0
//        textView.layer.cornerRadius = 5.0
//        return textView
//    }()
//
//    private lazy var addressTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Address"
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private lazy var areaTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Area (sq. m)"
//        textField.keyboardType = .numberPad
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private lazy var addPhotoButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Add Photo", for: .normal)
//        button.backgroundColor = .gray
//        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var addButton: UIButton = {
//        let button = UIButton()
//        let plusImage = UIImage(systemName: "plus.circle.fill")
//        button.setImage(plusImage, for: .normal)
//        button.tintColor = .green
//        button.addTarget(self, action: #selector(addListing), for: .touchUpInside)
//
//        let scale: CGFloat = 2.5
//        button.transform = CGAffineTransform(scaleX: scale, y: scale)
//
//        return button
//    }()
//
//    private var imageSources: [UIImage] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//
//        view.addSubview(slideshow)
//        view.addSubview(typeSegmentedControl)
//        view.addSubview(propertyTypeSegmentedControl)
//        view.addSubview(priceTextField)
//        view.addSubview(numberOfRoomsTextField)
//        view.addSubview(areaTextField)
//        view.addSubview(addressTextField)
//        view.addSubview(descriptionTextView)
//        view.addSubview(addPhotoButton)
//        view.addSubview(addButton)
//
//        slideshow.translatesAutoresizingMaskIntoConstraints = false
//        typeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        propertyTypeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        priceTextField.translatesAutoresizingMaskIntoConstraints = false
//        numberOfRoomsTextField.translatesAutoresizingMaskIntoConstraints = false
//        areaTextField.translatesAutoresizingMaskIntoConstraints = false
//        addressTextField.translatesAutoresizingMaskIntoConstraints = false
//        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
//        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
//        addButton.translatesAutoresizingMaskIntoConstraints = false
//        
//
//        
//        NSLayoutConstraint.activate([
//            slideshow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            slideshow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            slideshow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            slideshow.heightAnchor.constraint(equalToConstant: 200),
//            
//            typeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            typeSegmentedControl.centerYAnchor.constraint(equalTo: slideshow.bottomAnchor, constant: 20),
//            
//            propertyTypeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            propertyTypeSegmentedControl.centerYAnchor.constraint(equalTo: typeSegmentedControl.bottomAnchor, constant: 20),
//            
//            priceTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            priceTextField.centerYAnchor.constraint(equalTo: propertyTypeSegmentedControl.bottomAnchor, constant: 20),
//            
//            numberOfRoomsTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            numberOfRoomsTextField.centerYAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 20),
//            
//            areaTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            areaTextField.centerYAnchor.constraint(equalTo: numberOfRoomsTextField.bottomAnchor, constant: 20),
//
//            addressTextField.topAnchor.constraint(equalTo: areaTextField.bottomAnchor, constant: 20),
//               addressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//               addressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//               addressTextField.heightAnchor.constraint(equalToConstant: 20),
//            
//            // Constraints for descriptionTextView
//                descriptionTextView.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
//                descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//                descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//                descriptionTextView.heightAnchor.constraint(equalToConstant: 40),
//            
//            
////
//           
//            
//            addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//               addPhotoButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
//
//               addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//               addButton.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 20),
//            
//        ])
//
//        // Get the current user's UID
//        if let uid = Auth.auth().currentUser?.uid {
//            userId = uid
//        }
//    }
//
//    @objc private func addPhoto() {
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.delegate = self
//        imagePickerController.sourceType = .photoLibrary
//        imagePickerController.allowsEditing = false
//        present(imagePickerController, animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[.originalImage] as? UIImage {
//            imageSources.append(image)
//            slideshow.setImageInputs(imageSources.map { ImageSource(image: $0) })
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    private func clearPhotos() {
//        imageSources.removeAll()
//        slideshow.setImageInputs([])
//    }
//
//    @objc private func addListing() {
//        guard let userId = userId else {
//            print("User ID not found")
//            return
//        }
//
//        guard let priceText = priceTextField.text, !priceText.isEmpty,
//              let roomsText = numberOfRoomsTextField.text, !roomsText.isEmpty,
//              let areaText = areaTextField.text, !areaText.isEmpty,
//              let addressText = addressTextField.text, !addressText.isEmpty,
//              let descriptionText = descriptionTextView.text, !descriptionText.isEmpty else {
//                  let alertController = UIAlertController(title: "Warning", message: "Please fill in all fields", preferredStyle: .alert)
//                  alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                  present(alertController, animated: true, completion: nil)
//                  return
//        }
//
//        var photoURLs: [String] = []
//        let group = DispatchGroup()
//        for image in imageSources {
//            group.enter()
//            let storageRef = Storage.storage().reference().child("photos/\(UUID().uuidString).jpg")
//            if let uploadData = image.jpegData(compressionQuality: 0.5) {
//                storageRef.putData(uploadData, metadata: nil) { metadata, error in
//                    if let error = error {
//                        print("Error uploading photo: \(error.localizedDescription)")
//                        group.leave()
//                        return
//                    }
//                    storageRef.downloadURL { url, error in
//                        if let error = error {
//                            print("Error getting download URL: \(error.localizedDescription)")
//                            group.leave()
//                            return
//                        }
//                        if let downloadURL = url?.absoluteString {
//                            photoURLs.append(downloadURL)
//                        }
//                        group.leave()
//                    }
//                }
//            } else {
//                group.leave()
//            }
//        }
//
//        group.notify(queue: .main) {
//            let listing = RealEstateListing(
//                userId: userId,
//                type: self.typeSegmentedControl.selectedSegmentIndex == 0 ? .sale : .rent,
//                propertyType: self.propertyTypeSegmentedControl.selectedSegmentIndex == 0 ? .apartment : (self.propertyTypeSegmentedControl.selectedSegmentIndex == 1 ? .house : .other),
//                price: Int(priceText) ?? 0,
//                numberOfRooms: Int(roomsText) ?? 0,
//                area: Int(areaText) ?? 0,
//                photoURL: photoURLs.joined(separator: ", "),
//                description: descriptionText,
//                address: addressText
//            )
//
//            self.dataManager.addListing(listing: listing) { error in
//                if let error = error {
//                    print("Error adding listing: \(error.localizedDescription)")
//                } else {
//                    print("Listing added successfully")
//                    self.priceTextField.text = ""
//                    self.numberOfRoomsTextField.text = ""
//                    self.areaTextField.text = ""
//                    self.clearPhotos()
//                }
//            }
//        }
//    }
//
//}
//
//


import UIKit
import ImageSlideshow
import Firebase
import FirebaseStorage

class AddListingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let dataManager = RealEstateDataManager()
    private var userId: String?

    private lazy var slideshow: ImageSlideshow = {
        let slideshow = ImageSlideshow()
        slideshow.backgroundColor = .lightGray
        slideshow.contentScaleMode = .scaleAspectFill
        slideshow.clipsToBounds = true
        slideshow.activityIndicator = DefaultActivityIndicator()
        slideshow.slideshowInterval = 0
        return slideshow
    }()

    private lazy var typeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Sale", "Rent"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    private lazy var propertyTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Apartment", "House", "Other"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    private lazy var priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Price"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()

    private lazy var numberOfRoomsTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Number of Rooms"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()

    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Description"
        textView.textColor = .lightGray
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5.0
        return textView
    }()

    private lazy var addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Address"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private lazy var areaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Area (sq. m)"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()

    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Photo", for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        return button
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton()
        let plusImage = UIImage(systemName: "plus.circle.fill")
        button.setImage(plusImage, for: .normal)
        button.tintColor = .green
        button.addTarget(self, action: #selector(addListing), for: .touchUpInside)

        let scale: CGFloat = 2.5
        button.transform = CGAffineTransform(scaleX: scale, y: scale)

        return button
    }()

    private var imageSources: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(slideshow)
        view.addSubview(typeSegmentedControl)
        view.addSubview(propertyTypeSegmentedControl)
        view.addSubview(priceTextField)
        view.addSubview(numberOfRoomsTextField)
        view.addSubview(areaTextField)
        view.addSubview(addressTextField)
        view.addSubview(descriptionTextView)
        view.addSubview(addPhotoButton)
        view.addSubview(addButton)

        slideshow.translatesAutoresizingMaskIntoConstraints = false
        typeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        propertyTypeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        numberOfRoomsTextField.translatesAutoresizingMaskIntoConstraints = false
        areaTextField.translatesAutoresizingMaskIntoConstraints = false
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        

        
        NSLayoutConstraint.activate([
            slideshow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            slideshow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            slideshow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            slideshow.heightAnchor.constraint(equalToConstant: 200),
            
            typeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeSegmentedControl.centerYAnchor.constraint(equalTo: slideshow.bottomAnchor, constant: 20),
            
            propertyTypeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            propertyTypeSegmentedControl.centerYAnchor.constraint(equalTo: typeSegmentedControl.bottomAnchor, constant: 20),
            
            priceTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceTextField.centerYAnchor.constraint(equalTo: propertyTypeSegmentedControl.bottomAnchor, constant: 20),
            
            numberOfRoomsTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberOfRoomsTextField.centerYAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 20),
            
            areaTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            areaTextField.centerYAnchor.constraint(equalTo: numberOfRoomsTextField.bottomAnchor, constant: 20),

            addressTextField.topAnchor.constraint(equalTo: areaTextField.bottomAnchor, constant: 20),
               addressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               addressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               addressTextField.heightAnchor.constraint(equalToConstant: 20),
            
            // Constraints for descriptionTextView
                descriptionTextView.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
                descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                descriptionTextView.heightAnchor.constraint(equalToConstant: 40),
            
            
//
           
            
            addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               addPhotoButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),

               addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               addButton.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 20),
            
        ])

        // Get the current user's UID
        if let uid = Auth.auth().currentUser?.uid {
            userId = uid
        }
    }

    @objc private func addPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageSources.append(image)
            slideshow.setImageInputs(imageSources.map { ImageSource(image: $0) })
        }
        picker.dismiss(animated: true, completion: nil)
    }

    private func clearPhotos() {
        imageSources.removeAll()
        slideshow.setImageInputs([])
    }

    @objc private func addListing() {
        guard let userId = userId else {
            print("User ID not found")
            return
        }

        guard let priceText = priceTextField.text, !priceText.isEmpty,
              let roomsText = numberOfRoomsTextField.text, !roomsText.isEmpty,
              let areaText = areaTextField.text, !areaText.isEmpty,
              let addressText = addressTextField.text, !addressText.isEmpty,
              let descriptionText = descriptionTextView.text, !descriptionText.isEmpty else {
                  let alertController = UIAlertController(title: "Warning", message: "Please fill in all fields", preferredStyle: .alert)
                  alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                  present(alertController, animated: true, completion: nil)
                  return
        }

        guard !imageSources.isEmpty else {
            let alertController = UIAlertController(title: "Warning", message: "Please add at least one photo", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }

        var photoURLs: [String] = []
        let group = DispatchGroup()
        for image in imageSources {
            group.enter()
            let storageRef = Storage.storage().reference().child("photos/\(UUID().uuidString).jpg")
            if let uploadData = image.jpegData(compressionQuality: 0.5) {
                storageRef.putData(uploadData, metadata: nil) { metadata, error in
                    if let error = error {
                        print("Error uploading photo: \(error.localizedDescription)")
                    } else {
                        storageRef.downloadURL { url, error in
                            if let error = error {
                                print("Error getting download URL: \(error.localizedDescription)")
                            } else if let downloadURL = url?.absoluteString {
                                photoURLs.append(downloadURL)
                            }
                            group.leave()
                        }
                    }
                }
            } else {
                group.leave()
            }
        }

        group.notify(queue: .main) {
            let listing = RealEstateListing(
                userId: userId,
                type: self.typeSegmentedControl.selectedSegmentIndex == 0 ? .sale : .rent,
                propertyType: self.propertyTypeSegmentedControl.selectedSegmentIndex == 0 ? .apartment : (self.propertyTypeSegmentedControl.selectedSegmentIndex == 1 ? .house : .other),
                price: Int(priceText) ?? 0,
                numberOfRooms: Int(roomsText) ?? 0,
                area: Int(areaText) ?? 0,
                photoURL: photoURLs.joined(separator: ", "),
                description: descriptionText,
                address: addressText
            )

            self.dataManager.addListing(listing: listing) { error in
                if let error = error {
                    print("Error adding listing: \(error.localizedDescription)")
                } else {
                    print("Listing added successfully")
                    self.priceTextField.text = ""
                    self.numberOfRoomsTextField.text = ""
                    self.areaTextField.text = ""
                    self.addressTextField.text = ""
                    self.descriptionTextView.text = ""
                    self.clearPhotos()
                }
            }
        }
    }


}




