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
            image: UIImage(resource: .tabEditorialActive),
            selectedImage: nil
        )

        let profileViewController = ProfileViewController()
        let profilePresenter = ProfileViewPresenter()
        profileViewController.presenter = profilePresenter
        profilePresenter.view = profileViewController
        profileViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(resource: .tabProfileActive),
            selectedImage: nil
        )
        configureTabBar()
        viewControllers = [imagesListViewController, profileViewController]

    }

    private func configureTabBar() {

        tabBar.barTintColor = UIColor(resource: .ypBlackIOS)
        tabBar.backgroundColor = UIColor(resource: .ypBlackIOS)
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor(resource: .ypWhiteIOS)
        tabBar.unselectedItemTintColor = UIColor(resource: .ypGrayIOS)

    }

}
