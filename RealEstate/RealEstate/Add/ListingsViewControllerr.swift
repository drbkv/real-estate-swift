import UIKit
import FirebaseDatabase

class CreateListingViewController: UIViewController {

    // Определите UI-элементы

    private let typeLabel = UILabel()
    private let typePicker = UIPickerView()
    private let addressLabel = UILabel()
    private let addressTextField = UITextField()
    private let priceLabel = UILabel()
    private let priceTextField = UITextField()
    private let areaLabel = UILabel()
    private let areaTextField = UITextField()
    private let roomsLabel = UILabel()
    private let roomsTextField = UITextField()
    private let descriptionLabel = UILabel()
    private let descriptionTextView = UITextView()
    private let photosCollectionView = UICollectionView()

    // ...

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }

    // Настройка UI-элементов
    private func setupUI() {
        view.backgroundColor = .white

        // ... (добавьте код для создания и настройки UI-элементов)
    }

    // Настройка ограничений
    private func setupConstraints() {
        // ... (добавьте код для настройки ограничений между UI-элементами)
    }

    @IBAction func createListingButtonTapped(_ sender: UIButton) {
        guard let type = PropertyType(rawValue: typePicker.selectedRow(in: 0)),
              let address = addressTextField.text,
              let priceString = priceTextField.text, price = Int(priceString),
              let areaString = areaTextField.text, area = Int(areaString),
              let roomsString = roomsTextField.text, rooms = Int(roomsString),
              let description = descriptionTextView.text,
              !selectedPhotos.isEmpty else { return }

        let newListingId = UUID().uuidString

        let reference = Database.database().reference().child("listings").child(newListingId)
        let listingData = [
            "type": type.rawValue,
            "address": address,
            "price": price,
            "area": area,
            "rooms": rooms,
            "description": description
        ]

        reference.updateChildValues(listingData) { error in
            if let error = error {
                print("Failed to create listing: \(error)")
                return
            }

            // Загрузка фотографий в хранилище Firebase (необязательно)
            for photo in self.selectedPhotos {
                // ...
            }

            // Отображение сообщения об успешном создании
            let alert = UIAlertController(title: "Объявление создано", message: "Ваше объявление успешно создано.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }

    // ... (остальной код)
}
