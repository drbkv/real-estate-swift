import UIKit
import ImageSlideshow
import ImageSlideshowKingfisher

class UserListingsDetailViewController: UIViewController {

    var listing: RealEstateListing?

    private lazy var slideshow: ImageSlideshow = {
        let slideshow = ImageSlideshow()
        slideshow.contentScaleMode = .scaleAspectFill
        slideshow.layer.borderWidth = 1
        slideshow.layer.borderColor = UIColor.lightGray.cgColor // Добавляем светлую серую рамку
        return slideshow
    }()

    private lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.font = UIFont(name: "Arial", size: 18) // Устанавливаем шрифт и размер
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // Setup slideshow
        if let listing = listing, !listing.photoURL.isEmpty {
            let imageSources = listing.photoURL.split(separator: ",").map { imageUrlString in
                return KingfisherSource(urlString: String(imageUrlString.trimmingCharacters(in: .whitespaces)))!
            }
            slideshow.setImageInputs(imageSources)
        }
        view.addSubview(slideshow)
        slideshow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slideshow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            slideshow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            slideshow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            slideshow.heightAnchor.constraint(equalToConstant: 300)
        ])

        // Setup infoView
        view.addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: slideshow.bottomAnchor, constant: 20),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])

        // Setup textView
        infoView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -10)
        ])

        // Populate textView with listing information
        if let listing = listing {
            textView.text = """
                            Type: \(listing.type == .sale ? "For Sale" : "For Rent")
                            Property Type: \(listing.propertyType)
                            Price: \(listing.price)
                            Number of Rooms: \(listing.numberOfRooms)
                            Area: \(listing.area)
                            Description: \(listing.description)
                            Address: \(listing.address)
                            """
        }
    }

}

