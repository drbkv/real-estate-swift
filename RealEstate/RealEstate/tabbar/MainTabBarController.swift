import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create an instance of CreateListingViewController
        let createListingVC = AddListingViewController()
        createListingVC.title = "Добавить" // Set a title for the tab
        let addListingViewController = UINavigationController(rootViewController: createListingVC)
        addListingViewController.tabBarItem = UITabBarItem(title: "Добавить", image: UIImage(systemName: "plus.square"), tag: 0)

        // Create an instance of MyProfileViewController
        let myProfileVC = MyProfileViewController()
        myProfileVC.title = "Мой профиль"
        let myProfileNavigationController = UINavigationController(rootViewController: myProfileVC)
        myProfileNavigationController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 2)

        let userViewVc = UserListingsViewController()
        userViewVc.title = "Объявления пользователя"
        let userListingsViewController = UINavigationController(rootViewController: userViewVc)
        userListingsViewController.tabBarItem = UITabBarItem(title: "Мои объявления", image: UIImage(systemName: "list.dash"), tag: 1)

        let allViewVc = AllListingsViewController()
        allViewVc.title = "Все объявления"
        let allListingsViewController = UINavigationController(rootViewController: allViewVc)
        allListingsViewController.tabBarItem = UITabBarItem(title: "Все объявления", image: UIImage(systemName: "doc.text.magnifyingglass"), tag: 3)

        // Set the view controllers for the tab bar controller
        viewControllers = [addListingViewController, userListingsViewController, allListingsViewController, myProfileNavigationController]
    }
}
