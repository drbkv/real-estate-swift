//import Foundation
//import UIKit
//import Firebase
//
//class AllPropertiesViewController: UIViewController {
//
//    var tableView: UITableView!
//    var properties: [Property] = [] // Предполагая, что у вас есть модель Property
//    
//    var databaseRef: DatabaseReference!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//        setupTableView()
//        setupFirebase()
//        fetchProperties()
//    }
//
//    func setupFirebase() {
//        databaseRef = Database.database().reference()
//    }
//
//    func setupTableView() {
//        tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        
//        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//
//    func fetchProperties() {
//        databaseRef.child("properties").observeSingleEvent(of: .value) { snapshot in
//            guard let snapshotValue = snapshot.value as? [String: Any] else {
//                print("Ошибка: Не удалось получить данные из Firebase")
//                return
//            }
//            
//            self.properties.removeAll()
//            for (key, value) in snapshotValue {
//                guard let propertyData = value as? [String: Any] else {
//                    print("Ошибка: Неверный формат данных для свойства с ключом \(key)")
//                    continue
//                }
//                
//                if let property = Property(snapshot: snapshot, propertyData: propertyData) {
//                    self.properties.append(property)
//                } else {
//                    print("Ошибка: Не удалось инициализировать Property с данными: \(propertyData)")
//                }
//            }
//            self.tableView.reloadData()
//        } withCancel: { error in
//            print("Ошибка при получении данных из Firebase: \(error.localizedDescription)")
//        }
//    }
//}
//
//extension AllPropertiesViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return properties.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let property = properties[indexPath.row]
//        cell.textLabel?.text = "\(property.propertyType), \(property.price)"
//        return cell
//    }
//}
