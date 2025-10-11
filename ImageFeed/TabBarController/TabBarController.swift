import UIKit

final class TabBarController: UITabBarController {

    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)

        let imagesListViewController = storyboard.instantiateViewController(
            withIdentifier: "ImagesListViewController"
        )
        imagesListViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "tab_editorial_active"),
            selectedImage: nil
        )

        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "tab_profile_active"),
            selectedImage: nil
        )
        configureTabBar()
        self.viewControllers = [imagesListViewController, profileViewController]

    }

    private func configureTabBar() {

        tabBar.barTintColor = UIColor(named: "YP Black (iOS)")
        tabBar.backgroundColor = UIColor(named: "YP Black (iOS)")
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor(named: "YP White (iOS)")
        tabBar.unselectedItemTintColor = UIColor(named: "YP Gray (iOS)")

    }

}
