//import UIKit
//import Firebase
//import FirebaseStorage
//import SDWebImage
//
//class MyProfileViewController: UIViewController {
//
//    let emailLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 16)
//        return label
//    }()
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        return label
//    }()
//    let surnameLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//        return label
//    }()
//    let dateOfBirthLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 16)
//        return label
//    }()
//    let avatarImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.layer.cornerRadius = 75
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    var userData: UserData?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        title = "My profile"
//        setupUI()
//        setupNavigationBar()
//        fetchUserDataAndUpdateUI()
//    }
//
//    func setupNavigationBar() {
//        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
//        navigationItem.rightBarButtonItem = editButton
//    }
//
//    @objc func editButtonTapped() {
//        editUserData()
//    }
//
//    func setupUI() {
//        view.addSubview(avatarImageView)
//        view.addSubview(emailLabel)
//        view.addSubview(nameLabel)
//        view.addSubview(surnameLabel)
//        view.addSubview(dateOfBirthLabel)
//
//        NSLayoutConstraint.activate([
//            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
//            avatarImageView.heightAnchor.constraint(equalToConstant: 150),
//
//            emailLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
//            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//
//            nameLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
//            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//
//            surnameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
//            surnameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//
//            dateOfBirthLabel.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 20),
//            dateOfBirthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//        ])
//
//        let toolbar = UIToolbar()
//        toolbar.translatesAutoresizingMaskIntoConstraints = false
//        toolbar.tintColor = .black
//        view.addSubview(toolbar)
//
//        let myListingButton = UIBarButtonItem(title: "Мои объявления", style: .plain, target: self, action: #selector(myListingsButtonTapped))
//        myListingButton.tintColor = .green
//
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//
//        let logoutButton = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(logoutButtonTapped))
//        logoutButton.tintColor = .red
//
//        toolbar.items = [flexibleSpace, myListingButton, flexibleSpace, logoutButton, flexibleSpace]
//
//        NSLayoutConstraint.activate([
//            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            toolbar.topAnchor.constraint(equalTo: dateOfBirthLabel.bottomAnchor, constant: 20), // немного ниже dateOfBirthLabel
//        ])
//    }
//
//
//    @objc func myListingsButtonTapped() {
//        let userListingsViewController = UserListingsViewController()
//        navigationController?.pushViewController(userListingsViewController, animated: true)
//    }
//
//    @objc func logoutButtonTapped() {
//        do {
//            try Auth.auth().signOut()
//            let loginViewController = LoginViewController()
//            navigationController?.setViewControllers([loginViewController], animated: true)
//        } catch let signOutError as NSError {
//            print("Error signing out: %@", signOutError)
//        }
//    }
//
//    private func fetchUserDataAndUpdateUI() {
//        guard let currentUser = Auth.auth().currentUser else {
//            return
//        }
//
//        let databaseReference = Database.database().reference().child("users").child(currentUser.uid)
//
//        databaseReference.observeSingleEvent(of: .value) { [weak self] (snapshot) in
//            guard let self = self else { return }
//
//            if let userDataDictionary = snapshot.value as? [String: Any] {
//                let email = currentUser.email ?? ""
//                let name = userDataDictionary["name"] as? String ?? ""
//                let surname = userDataDictionary["surname"] as? String ?? ""
//                let dateOfBirth = userDataDictionary["dateOfBirth"] as? String ?? ""
//                let avatarURL = userDataDictionary["avatarURL"] as? String ?? ""
//
//                self.userData = UserData(email: email, password: "", name: name, surname: surname, dateOfBirth: dateOfBirth, avatarURL: avatarURL)
//                self.updateUI()
//            } else {
//                self.showDataInputAlert()
//            }
//        }
//    }
//
//    private func showDataInputAlert() {
//        let alert = UIAlertController(title: "Enter Your Details", message: nil, preferredStyle: .alert)
//        alert.addTextField { textField in
//            textField.placeholder = "Name"
//        }
//        alert.addTextField { textField in
//            textField.placeholder = "Surname"
//        }
//        alert.addTextField { textField in
//            textField.placeholder = "Date of Birth"
//        }
//
//        let selectPhotoAction = UIAlertAction(title: "Select Photo", style: .default) { [weak self] _ in
//            guard let self = self else { return }
//            let picker = UIImagePickerController()
//            picker.sourceType = .photoLibrary
//            picker.delegate = self
//            self.present(picker, animated: true, completion: nil)
//        }
//        alert.addAction(selectPhotoAction)
//
//        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
//            guard let self = self else { return }
//            guard let name = alert.textFields?[0].text,
//                  let surname = alert.textFields?[1].text,
//                  let dateOfBirth = alert.textFields?[2].text else {
//                return
//            }
//            // We don't need to pass avatarImage here
//            self.userData = UserData(email: self.userData?.email ?? "", password: "", name: name, surname: surname, dateOfBirth: dateOfBirth)
//            self.saveUserDataToDatabase()
//            self.updateUI()
//        }
//        alert.addAction(saveAction)
//
//        present(alert, animated: true, completion: nil)
//    }
//
//    private func saveUserDataToDatabase() {
//        guard let currentUser = Auth.auth().currentUser, let userData = userData else {
//            return
//        }
//
//        let storageReference = Storage.storage().reference().child("avatars").child("\(currentUser.uid).jpg")
//
//        if let avatarImage = self.avatarImageView.image,
//           let avatarData = avatarImage.jpegData(compressionQuality: 0.5) {
//            storageReference.putData(avatarData, metadata: nil) { (metadata, error) in
//                if let error = error {
//                    print("Error uploading avatar: \(error.localizedDescription)")
//                } else {
//                    storageReference.downloadURL { (url, error) in
//                        if let downloadURL = url {
//                            let userDataDictionary: [String: Any] = [
//                                "email": userData.email,
//                                "name": userData.name ?? "",
//                                "surname": userData.surname ?? "",
//                                "dateOfBirth": userData.dateOfBirth ?? "",
//                                "avatarURL": downloadURL.absoluteString
//                            ]
//
//                            let databaseReference = Database.database().reference().child("users").child(currentUser.uid)
//
//                            databaseReference.setValue(userDataDictionary) { (error, _) in
//                                if let error = error {
//                                    print("Error saving user data: \(error.localizedDescription)")
//                                } else {
//                                    print("User data successfully saved in the database")
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//
//    private func editUserData() {
//        guard let currentUser = Auth.auth().currentUser else {
//            return
//        }
//
//        let alert = UIAlertController(title: "Edit Your Details", message: nil, preferredStyle: .alert)
//        alert.addTextField { textField in
//            textField.placeholder = "Name"
//            textField.text = self.userData?.name ?? ""
//        }
//        alert.addTextField { textField in
//            textField.placeholder = "Surname"
//            textField.text = self.userData?.surname ?? ""
//        }
//        alert.addTextField { textField in
//            textField.placeholder = "Date of Birth"
//            textField.text = self.userData?.dateOfBirth ?? ""
//        }
//        let selectPhotoAction = UIAlertAction(title: "Select Photo", style: .default) { [weak self] _ in
//            guard let self = self else { return }
//            let picker = UIImagePickerController()
//            picker.sourceType = .photoLibrary
//            picker.delegate = self
//            self.present(picker, animated: true, completion: nil)
//        }
//        alert.addAction(selectPhotoAction)
//
//        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
//            guard let self = self else { return }
//            guard let name = alert.textFields?[0].text,
//                  let surname = alert.textFields?[1].text,
//                  let dateOfBirth = alert.textFields?[2].text else {
//                return
//            }
//            self.userData = UserData(email: self.userData?.email ?? "", password: "", name: name, surname: surname, dateOfBirth: dateOfBirth, avatarURL: self.userData?.avatarURL)
//            self.saveUserDataToDatabase()
//            self.updateUI()
//        }
//        alert.addAction(saveAction)
//
//        present(alert, animated: true, completion: nil)
//    }
//
//    private func updateUI() {
//        guard let userData = userData else { return }
//
//        emailLabel.text = "Email: \(userData.email)"
//        nameLabel.text = "First Name: \(userData.name ?? "")"
//        surnameLabel.text = "Last Name: \(userData.surname ?? "")"
//        dateOfBirthLabel.text = "Date of Birth: \(userData.dateOfBirth ?? "")"
//        if let avatarURL = userData.avatarURL, let url = URL(string: avatarURL) {
//            avatarImageView.sd_setImage(with: url, completed: nil)
//        }
//    }
//}
//
//extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[.originalImage] as? UIImage {
//            avatarImageView.image = image
//        }
//        dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//}


import UIKit
import Firebase
import FirebaseStorage
import SDWebImage

class MyProfileViewController: UIViewController {

    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    let surnameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    let dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        return imageView
    }()

    var userData: UserData?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "My profile"
        setupUI()
        setupNavigationBar()
        fetchUserDataAndUpdateUI()
    }

    func setupNavigationBar() {
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = editButton
    }

    @objc func editButtonTapped() {
        editUserData()
    }

    func setupUI() {
        view.addSubview(avatarImageView)
        view.addSubview(emailLabel)
        view.addSubview(nameLabel)
        view.addSubview(surnameLabel)
        view.addSubview(dateOfBirthLabel)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150),

            emailLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            nameLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            surnameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            surnameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            dateOfBirthLabel.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 20),
            dateOfBirthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.tintColor = .black
        view.addSubview(toolbar)

        let myListingButton = UIBarButtonItem(title: "Мои объявления", style: .plain, target: self, action: #selector(myListingsButtonTapped))
        myListingButton.tintColor = .green

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let logoutButton = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(logoutButtonTapped))
        logoutButton.tintColor = .red

        toolbar.items = [flexibleSpace, myListingButton, flexibleSpace, logoutButton, flexibleSpace]

        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.topAnchor.constraint(equalTo: dateOfBirthLabel.bottomAnchor, constant: 20), // немного ниже dateOfBirthLabel
        ])
    }


    @objc func myListingsButtonTapped() {
        let userListingsViewController = UserListingsViewController()
        navigationController?.pushViewController(userListingsViewController, animated: true)
    }

    @objc func logoutButtonTapped() {
        do {
            try Auth.auth().signOut()
            let loginViewController = LoginViewController()
            navigationController?.setViewControllers([loginViewController], animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    private func fetchUserDataAndUpdateUI() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }

        let databaseReference = Database.database().reference().child("users").child(currentUser.uid)

        databaseReference.observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let self = self else { return }

            if let userDataDictionary = snapshot.value as? [String: Any] {
                let email = currentUser.email ?? ""
                let name = userDataDictionary["name"] as? String ?? ""
                let surname = userDataDictionary["surname"] as? String ?? ""
                let dateOfBirth = userDataDictionary["dateOfBirth"] as? String ?? ""
                let avatarURL = userDataDictionary["avatarURL"] as? String ?? ""

                self.userData = UserData(email: email, password: "", name: name, surname: surname, dateOfBirth: dateOfBirth, avatarURL: avatarURL)
                self.updateUI()
            } else {
                self.showDataInputAlert()
            }
        }
    }

    private func showDataInputAlert() {
        let alert = UIAlertController(title: "Enter Your Details", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        alert.addTextField { textField in
            textField.placeholder = "Surname"
        }
        alert.addTextField { textField in
            textField.placeholder = "Date of Birth"
        }

        let selectPhotoAction = UIAlertAction(title: "Select Photo", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        alert.addAction(selectPhotoAction)

        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self = self else { return }
            guard let name = alert.textFields?[0].text,
                  let surname = alert.textFields?[1].text,
                  let dateOfBirth = alert.textFields?[2].text else {
                return
            }
            // We don't need to pass avatarImage here
            self.userData = UserData(email: self.userData?.email ?? "", password: "", name: name, surname: surname, dateOfBirth: dateOfBirth, avatarURL: nil)

            self.saveUserDataToDatabase()
            self.updateUI()
        }
        alert.addAction(saveAction)

        present(alert, animated: true, completion: nil)
    }

    private func saveUserDataToDatabase() {
        guard let currentUser = Auth.auth().currentUser, let userData = userData else {
            return
        }

        let storageReference = Storage.storage().reference().child("avatars").child("\(currentUser.uid).jpg")

        if let avatarImage = self.avatarImageView.image,
           let avatarData = avatarImage.jpegData(compressionQuality: 0.5) {
            storageReference.putData(avatarData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error uploading avatar: \(error.localizedDescription)")
                } else {
                    storageReference.downloadURL { (url, error) in
                        if let downloadURL = url {
                            var userDataDictionary: [String: Any] = [
                                "email": userData.email,
                                "name": userData.name ?? "",
                                "surname": userData.surname ?? "",
                                "dateOfBirth": userData.dateOfBirth ?? "",
                                "avatarURL": downloadURL.absoluteString
                            ]

                            // Update only if data has changed
                            if let existingAvatarURL = self.userData?.avatarURL, existingAvatarURL == downloadURL.absoluteString {
                                userDataDictionary.removeValue(forKey: "avatarURL")
                            }

                            let databaseReference = Database.database().reference().child("users").child(currentUser.uid)

                            databaseReference.updateChildValues(userDataDictionary) { (error, _) in
                                if let error = error {
                                    print("Error saving user data: \(error.localizedDescription)")
                                } else {
                                    print("User data successfully saved in the database")
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private func editUserData() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }

        let alert = UIAlertController(title: "Edit Your Details", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Name"
            textField.text = self.userData?.name ?? ""
        }
        alert.addTextField { textField in
            textField.placeholder = "Surname"
            textField.text = self.userData?.surname ?? ""
        }
        alert.addTextField { textField in
            textField.placeholder = "Date of Birth"
            textField.text = self.userData?.dateOfBirth ?? ""
        }
        let selectPhotoAction = UIAlertAction(title: "Select Photo", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        alert.addAction(selectPhotoAction)

        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self = self else { return }
            guard let name = alert.textFields?[0].text,
                  let surname = alert.textFields?[1].text,
                  let dateOfBirth = alert.textFields?[2].text else {
                return
            }
            // Check if avatar image has changed
            var avatarURL: String? = nil
            if let existingAvatarURL = self.userData?.avatarURL, let currentAvatarURL = self.avatarImageView.sd_imageURL?.absoluteString, existingAvatarURL != currentAvatarURL {
                avatarURL = currentAvatarURL
            }
            self.userData = UserData(email: self.userData?.email ?? "", password: "", name: name, surname: surname, dateOfBirth: dateOfBirth, avatarURL: avatarURL)
            self.saveUserDataToDatabase()
            self.updateUI()
        }
        alert.addAction(saveAction)

        let deletePhotoAction = UIAlertAction(title: "Delete Photo", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.avatarImageView.image = nil
            // Set avatarURL to nil to delete the avatar from the database
            self.userData?.avatarURL = nil
            self.saveUserDataToDatabase()
        }
        alert.addAction(deletePhotoAction)

        present(alert, animated: true, completion: nil)
    }


    private func updateUI() {
        guard let userData = userData else { return }

        emailLabel.text = "Email: \(userData.email)"
        nameLabel.text = "First Name: \(userData.name ?? "")"
        surnameLabel.text = "Last Name: \(userData.surname ?? "")"
        dateOfBirthLabel.text = "Date of Birth: \(userData.dateOfBirth ?? "")"
        if let avatarURL = userData.avatarURL, let url = URL(string: avatarURL) {
            avatarImageView.sd_setImage(with: url, completed: nil)
        }
    }
}

extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            avatarImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
