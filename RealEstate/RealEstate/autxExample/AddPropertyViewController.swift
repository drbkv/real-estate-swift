////import UIKit
////import Firebase
////import FirebaseStorage
////
////class AddPropertyViewController: UIViewController {
////
////    var propertyTypeSegmentedControl: UISegmentedControl!
////    var numberOfRoomsTextField: UITextField!
////    var priceTextField: UITextField!
////    var buildingTypeTextField: UITextField!
////    var floorTextField: UITextField!
////    var areaTextField: UITextField!
////    var descriptionTextView: UITextView!
////    var saveButton: UIButton!
////    var photoButton: UIButton!
////    
////    var storageRef: StorageReference!
////    var databaseRef: DatabaseReference!
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        view.backgroundColor = .white // Устанавливаем белый фон
////
////        setupViews()
////        setupFirebase()
////    }
////    
////    func setupFirebase() {
////        storageRef = Storage.storage().reference()
////        databaseRef = Database.database().reference()
////    }
////
////    func setupViews() {
////        // Создание элементов управления
////        propertyTypeSegmentedControl = UISegmentedControl(items: ["Apartment", "Property"])
////        numberOfRoomsTextField = UITextField()
////        priceTextField = UITextField()
////        buildingTypeTextField = UITextField()
////        floorTextField = UITextField()
////        areaTextField = UITextField()
////        descriptionTextView = UITextView()
////        saveButton = UIButton(type: .system)
////        photoButton = UIButton(type: .system)
////
////        // Настройка параметров элементов управления
////        propertyTypeSegmentedControl.selectedSegmentIndex = 0
////        numberOfRoomsTextField.placeholder = "Number of rooms"
////        priceTextField.placeholder = "Price"
////        buildingTypeTextField.placeholder = "Building type"
////        floorTextField.placeholder = "Floor"
////        areaTextField.placeholder = "Area"
////        descriptionTextView.text = "Description"
////        saveButton.setTitle("Save", for: .normal)
////        photoButton.setTitle("Add Photo", for: .normal)
////
////        // Добавление обработчика нажатия на кнопку "Save"
////        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
////        photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
////
////        // Добавление элементов на экран с использованием UIStackView
////        let stackView = UIStackView(arrangedSubviews: [propertyTypeSegmentedControl, numberOfRoomsTextField, priceTextField, buildingTypeTextField, floorTextField, areaTextField, descriptionTextView, saveButton, photoButton])
////        stackView.axis = .vertical
////        stackView.spacing = 20
////        stackView.translatesAutoresizingMaskIntoConstraints = false
////        view.addSubview(stackView)
////
////        // Настройка layout constraints для stackView
////        NSLayoutConstraint.activate([
////            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
////            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
////            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
////            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
////        ])
////    }
////
////    @objc func saveButtonTapped() {
////        guard let propertyType = propertyTypeSegmentedControl.titleForSegment(at: propertyTypeSegmentedControl.selectedSegmentIndex),
////              let numberOfRooms = numberOfRoomsTextField.text,
////              let price = priceTextField.text,
////              let buildingType = buildingTypeTextField.text,
////              let floor = floorTextField.text,
////              let area = areaTextField.text,
////              let description = descriptionTextView.text else {
////            return
////        }
////
////        let propertyData: [String: Any] = [
////            "propertyType": propertyType,
////            "numberOfRooms": numberOfRooms,
////            "price": price,
////            "buildingType": buildingType,
////            "floor": floor,
////            "area": area,
////            "description": description
////        ]
////
////        let propertyRef = databaseRef.child("properties").childByAutoId()
////
////        propertyRef.setValue(propertyData) { error, ref in
////            if let error = error {
////                print("Error saving data: \(error.localizedDescription)")
////            } else {
////                print("Property data saved successfully!")
////                self.clearFields()
////            }
////        }
////    }
////    
////    @objc func photoButtonTapped() {
////        let imagePicker = UIImagePickerController()
////        imagePicker.delegate = self
////        present(imagePicker, animated: true, completion: nil)
////    }
////
////    func clearFields() {
////        numberOfRoomsTextField.text = ""
////        priceTextField.text = ""
////        buildingTypeTextField.text = ""
////        floorTextField.text = ""
////        areaTextField.text = ""
////        descriptionTextView.text = ""
////    }
////}
////
////extension AddPropertyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
////    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
////        picker.dismiss(animated: true, completion: nil)
////
////        guard let image = info[.originalImage] as? UIImage else {
////            return
////        }
////
////        let imageName = UUID().uuidString
////        let imageRef = storageRef.child("images/\(imageName).jpg")
////
////        if let imageData = image.jpegData(compressionQuality: 0.5) {
////            let metadata = StorageMetadata()
////            metadata.contentType = "image/jpeg"
////
////            imageRef.putData(imageData, metadata: metadata) { metadata, error in
////                guard let _ = metadata else {
////                    print("Error uploading image: \(error?.localizedDescription ?? "")")
////                    return
////                }
////
////                imageRef.downloadURL { url, error in
////                    guard let downloadURL = url else {
////                        print("Error getting download URL: \(error?.localizedDescription ?? "")")
////                        return
////                    }
////
////                    self.saveImageDataToDatabase(downloadURL.absoluteString)
////                }
////            }
////        }
////    }
////
////    func saveImageDataToDatabase(_ imageURL: String) {
////        guard let propertyType = propertyTypeSegmentedControl.titleForSegment(at: propertyTypeSegmentedControl.selectedSegmentIndex),
////              let numberOfRooms = numberOfRoomsTextField.text,
////              let price = priceTextField.text,
////              let buildingType = buildingTypeTextField.text,
////              let floor = floorTextField.text,
////              let area = areaTextField.text,
////              let description = descriptionTextView.text else {
////            return
////        }
////
////        let propertyData: [String: Any] = [
////            "propertyType": propertyType,
////            "numberOfRooms": numberOfRooms,
////            "price": price,
////            "buildingType": buildingType,
////            "floor": floor,
////            "area": area,
////            "description": description,
////            "imageURL": imageURL
////        ]
////
////        let propertyRef = databaseRef.child("properties").childByAutoId()
////
////        propertyRef.setValue(propertyData) { error, ref in
////            if let error = error {
////                print("Error saving data: \(error.localizedDescription)")
////            } else {
////                print("Property data saved successfully!")
////                self.clearFields()
////            }
////        }
////    }
////}
//
//
//import UIKit
//import Firebase
//import FirebaseStorage
//
//class AddPropertyViewController: UIViewController {
//
//    var propertyTypeSegmentedControl: UISegmentedControl!
//    var numberOfRoomsTextField: UITextField!
//    var priceTextField: UITextField!
//    var buildingTypeTextField: UITextField!
//    var floorTextField: UITextField!
//    var areaTextField: UITextField!
//    var descriptionTextView: UITextView!
//    var saveButton: UIButton!
//    var photoButton: UIButton!
//    
//    var storageRef: StorageReference!
//    var databaseRef: DatabaseReference!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//        setupViews()
//        setupFirebase()
//    }
//
//    func setupFirebase() {
//        storageRef = Storage.storage().reference()
//        databaseRef = Database.database().reference()
//    }
//
//    func setupViews() {
//        propertyTypeSegmentedControl = UISegmentedControl(items: ["Дом", "Квартира", "Земельный участок", "Коммерческая недвижимость"])
//        numberOfRoomsTextField = UITextField()
//        priceTextField = UITextField()
//        buildingTypeTextField = UITextField()
//        floorTextField = UITextField()
//        areaTextField = UITextField()
//        descriptionTextView = UITextView()
//        saveButton = UIButton(type: .system)
//        photoButton = UIButton(type: .system)
//
//        propertyTypeSegmentedControl.selectedSegmentIndex = 0
//        numberOfRoomsTextField.placeholder = "Количество комнат (например, 3)"
//        priceTextField.placeholder = "Цена (USD)"
//        buildingTypeTextField.placeholder = "Тип здания (например, Многоэтажный дом)"
//        floorTextField.placeholder = "Этаж (например, 2)"
//        areaTextField.placeholder = "Площадь (кв. м)"
//        descriptionTextView.text = "Введите описание недвижимости здесь..."
//        saveButton.setTitle("Сохранить", for: .normal)
//        photoButton.setTitle("Добавить фото", for: .normal)
//
//        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
//        photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
//        
//        saveButton.backgroundColor = .green
//        photoButton.backgroundColor = .green
//        propertyTypeSegmentedControl.tintColor = .green
//
//        let stackView = UIStackView(arrangedSubviews: [propertyTypeSegmentedControl, numberOfRoomsTextField, priceTextField, buildingTypeTextField, floorTextField, areaTextField, descriptionTextView, saveButton, photoButton])
//        stackView.axis = .vertical
//        stackView.spacing = 20
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(stackView)
//
//        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
//        ])
//    }
//
//    @objc func saveButtonTapped() {
//        guard let currentUser = Auth.auth().currentUser else {
//            print("Ошибка: Текущий пользователь не определен")
//            return
//        }
//        
//        guard let propertyType = propertyTypeSegmentedControl.titleForSegment(at: propertyTypeSegmentedControl.selectedSegmentIndex),
//              let numberOfRooms = numberOfRoomsTextField.text,
//              let price = priceTextField.text,
//              let buildingType = buildingTypeTextField.text,
//              let floor = floorTextField.text,
//              let area = areaTextField.text,
//              let description = descriptionTextView.text else {
//            print("Ошибка: Отсутствуют обязательные данные")
//            return
//        }
//
//        let propertyData: [String: Any] = [
//            "userID": currentUser.uid,
//            "propertyType": propertyType,
//            "numberOfRooms": numberOfRooms,
//            "price": price,
//            "buildingType": buildingType,
//            "floor": floor,
//            "area": area,
//            "description": description
//        ]
//
//        let propertyRef = databaseRef.child("properties").childByAutoId()
//
//        propertyRef.setValue(propertyData) { error, ref in
//            if let error = error {
//                print("Ошибка сохранения данных: \(error.localizedDescription)")
//            } else {
//                print("Данные недвижимости успешно сохранены!")
//                self.clearFields()
//            }
//        }
//    }
//
//    
//    @objc func photoButtonTapped() {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        present(imagePicker, animated: true, completion: nil)
//    }
//
//    func clearFields() {
//        numberOfRoomsTextField.text = ""
//        priceTextField.text = ""
//        buildingTypeTextField.text = ""
//        floorTextField.text = ""
//        areaTextField.text = ""
//        descriptionTextView.text = ""
//    }
//}
//
//extension AddPropertyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//
//        guard let image = info[.originalImage] as? UIImage else {
//            return
//        }
//
//        let imageName = UUID().uuidString
//        let imageRef = storageRef.child("images/\(imageName).jpg")
//
//        if let imageData = image.jpegData(compressionQuality: 0.5) {
//            let metadata = StorageMetadata()
//            metadata.contentType = "image/jpeg"
//
//            imageRef.putData(imageData, metadata: metadata) { metadata, error in
//                guard let _ = metadata else {
//                    print("Ошибка загрузки изображения: \(error?.localizedDescription ?? "")")
//                    return
//                }
//
//                imageRef.downloadURL { url, error in
//                    guard let downloadURL = url else {
//                        print("Ошибка получения URL для загрузки: \(error?.localizedDescription ?? "")")
//                        return
//                    }
//
//                    self.saveImageDataToDatabase(downloadURL.absoluteString)
//                }
//            }
//        }
//    }
//
//    func saveImageDataToDatabase(_ imageURL: String) {
//        guard let propertyType = propertyTypeSegmentedControl.titleForSegment(at: propertyTypeSegmentedControl.selectedSegmentIndex),
//              let numberOfRooms = numberOfRoomsTextField.text,
//              let price = priceTextField.text,
//              let buildingType = buildingTypeTextField.text,
//              let floor = floorTextField.text,
//              let area = areaTextField.text,
//              let description = descriptionTextView.text else {
//            return
//        }
//
//        let propertyData: [String: Any] = [
//            "propertyType": propertyType,
//            "numberOfRooms": numberOfRooms,
//            "price": price,
//            "buildingType": buildingType,
//            "floor": floor,
//            "area": area,
//            "description": description,
//            "imageURL": imageURL
//        ]
//
//        let propertyRef = databaseRef.child("properties").childByAutoId()
//
//        propertyRef.setValue(propertyData) { error, ref in
//            if let error = error {
//                print("Ошибка сохранения данных: \(error.localizedDescription)")
//            } else {
//                print("Данные недвижимости успешно сохранены!")
//                self.clearFields()
//            }
//        }
//    }
//}
