//import Foundation
//import UIKit
//import SDWebImage
//
//class ListingDetailsViewController: UIViewController {
//
//    var listing: RealEstateListing
//    private var detailsLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.textAlignment = .left
//        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        label.textColor = .black
//        label.backgroundColor = .white
//        label.layer.cornerRadius = 8
//        label.layer.masksToBounds = true
//        label.layer.borderWidth = 1
//        label.layer.borderColor = UIColor.lightGray.cgColor
//        return label
//    }()
//    
//    private let photoSliderScrollView = UIScrollView()
//    private let pageControl = UIPageControl()
//    private let prevButton = UIButton(type: .system)
//    private let nextButton = UIButton(type: .system)
//
//    init(listing: RealEstateListing) {
//        self.listing = listing
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//
//        setupPhotoSlider()
//        addPhotosToSlider()
//        addDetailsLabel()
//    }
//
//    private func setupPhotoSlider() {
//        photoSliderScrollView.isPagingEnabled = true
//        photoSliderScrollView.showsHorizontalScrollIndicator = false
//        photoSliderScrollView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(photoSliderScrollView)
//        
//        pageControl.numberOfPages = listing.photos.count
//        pageControl.currentPage = 0
//        pageControl.pageIndicatorTintColor = UIColor.lightGray
//        pageControl.currentPageIndicatorTintColor = UIColor.black
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(pageControl)
//        
//        prevButton.setTitle("<", for: .normal)
//        prevButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
//        prevButton.addTarget(self, action: #selector(prevButtonTapped), for: .touchUpInside)
//        prevButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(prevButton)
//        
//        nextButton.setTitle(">", for: .normal)
//        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
//        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(nextButton)
//        
//        NSLayoutConstraint.activate([
//            photoSliderScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            photoSliderScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            photoSliderScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            photoSliderScrollView.heightAnchor.constraint(equalToConstant: 300),
//            
//            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
//            
//            prevButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor),
//            prevButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            
//            nextButton.centerYAnchor.constraint(equalTo: pageControl.centerYAnchor),
//            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
//        ])
//    }
//
//    private func addPhotosToSlider() {
//        for (index, photoURL) in listing.photos.enumerated() {
//            let imageView = UIImageView()
//            imageView.contentMode = .scaleAspectFill
//            imageView.clipsToBounds = true
//            imageView.sd_setImage(with: URL(string: photoURL), placeholderImage: nil, options: [], context: nil)
//            imageView.frame = CGRect(x: CGFloat(index) * view.frame.size.width, y: 0, width: view.frame.size.width, height: 300)
//            photoSliderScrollView.addSubview(imageView)
//        }
//
//        photoSliderScrollView.contentSize = CGSize(width: CGFloat(listing.photos.count) * view.frame.size.width, height: 300)
//    }
//
//    private func addDetailsLabel() {
//        detailsLabel.text = """
//            Тип: \(listing.type.rawValue)
//            Тип собственности: \(listing.propertyType.rawValue)
//            Цена: \(listing.price)
//            Количество комнат: \(listing.numberOfRooms)
//            Тип здания: \(listing.buildingType.rawValue)
//            Год постройки: \(listing.yearBuilt)
//            Этаж: \(listing.floor)
//            Площадь: \(listing.area)
//            Город: \(listing.city)
//            Адрес: \(listing.address)
//        """
//        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(detailsLabel)
//
//        NSLayoutConstraint.activate([
//            detailsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 420),
//            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
//        ])
//    }
//
//    @objc private func prevButtonTapped() {
//        let newPage = max(pageControl.currentPage - 1, 0)
//        let xOffset = CGFloat(newPage) * photoSliderScrollView.frame.size.width
//        photoSliderScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
//        pageControl.currentPage = newPage
//    }
//
//    @objc private func nextButtonTapped() {
//        let newPage = min(pageControl.currentPage + 1, listing.photos.count - 1)
//        let xOffset = CGFloat(newPage) * photoSliderScrollView.frame.size.width
//        photoSliderScrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
//        pageControl.currentPage = newPage
//    }
//}
