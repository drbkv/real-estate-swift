//import Firebase
//struct Property {
//    var buildingType: String
//    var description: String
//    var imageURL: String
//    var propertyType: String
//    var numberOfRooms: Int
//    var price: Double
//    var area: Double
//    var floor: Int
//
//    init?(snapshot: DataSnapshot, propertyData: [String: Any]) {
//        guard
//            let buildingType = propertyData["buildingType"] as? String,
//            let description = propertyData["description"] as? String,
//            let imageURL = propertyData["imageURL"] as? String,
//            let propertyType = propertyData["propertyType"] as? String,
//            let numberOfRooms = propertyData["numberOfRooms"] as? Int,
//            let priceString = propertyData["price"] as? String,
//            let price = Double(priceString),
//            let areaString = propertyData["area"] as? String,
//            let area = Double(areaString),
//            let floorString = propertyData["floor"] as? String,
//            let floor = Int(floorString)
//        else {
//            print("Ошибка: Неверный формат данных для свойства")
//            return nil
//        }
//
//        self.buildingType = buildingType
//        self.description = description
//        self.imageURL = imageURL
//        self.propertyType = propertyType
//        self.numberOfRooms = numberOfRooms
//        self.price = price
//        self.area = area
//        self.floor = floor
//    }
//}
