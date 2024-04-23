//import Foundation
//import UIKit
//import Firebase
//import Alamofire
//
//class FirebaseAuthManagerViewController: UIViewController {
//    let authManager = FirebaseAuthManager.shared
//
//    let emailTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Email"
//        textField.borderStyle = .roundedRect
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//
//    let passwordTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Password"
//        textField.isSecureTextEntry = true
//        textField.borderStyle = .roundedRect
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//
//    let resultLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//
//        setupViews()
//    }
//
//    func setupViews() {
//        view.addSubview(emailTextField)
//        view.addSubview(passwordTextField)
//        view.addSubview(resultLabel)
//
//        NSLayoutConstraint.activate([
//            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//            emailTextField.widthAnchor.constraint(equalToConstant: 200),
//
//            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
//            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
//
//            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            resultLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
//        ])
//
//        let registerButton: UIButton = {
//            let button = UIButton(type: .system)
//            button.setTitle("Register", for: .normal)
//            button.setTitleColor(.black, for: .normal)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.addTarget(self, action: #selector(registerButtonTapped(_:)), for: .touchUpInside)
//            return button
//        }()
//
//        let loginButton: UIButton = {
//            let button = UIButton(type: .system)
//            button.setTitle("Login", for: .normal)
//            button.setTitleColor(.black, for: .normal)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
//            return button
//        }()
//
//        view.addSubview(registerButton)
//        view.addSubview(loginButton)
//
//        NSLayoutConstraint.activate([
//            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            registerButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
//
//            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
//        ])
//    }
//
//    @objc func registerButtonTapped(_ sender: UIButton) {
//        guard let email = emailTextField.text, let password = passwordTextField.text else {
//            return
//        }
//
//        authManager.registerUser(email: email, password: password) { [weak self] error in
//            if let error = error {
//                self?.resultLabel.text = "Registration failed: \(error.localizedDescription)"
//            } else {
//                self?.resultLabel.text = "Registration successful"
//            }
//        }
//    }
//
//    @objc func loginButtonTapped(_ sender: UIButton) {
//        guard let email = emailTextField.text, let password = passwordTextField.text else {
//            return
//        }
//
//        authManager.loginUser(email: email, password: password) { [weak self] error in
//            if let error = error {
//                self?.resultLabel.text = "Login failed: \(error.localizedDescription)"
//            } else {
//                self?.resultLabel.text = "Login successful"
//            }
//        }
//    }
//}
//
