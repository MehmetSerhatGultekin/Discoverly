//
//  MainTabBarController.swift
//  Discoverly
//
//  Created by Mehmet Serhat Gültekin on 3.07.2025.
//
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Tab bar ayarları buraya gelecek
        
        let homeVc = HomeViewController()
        let nav1 = createNav(
            with: "Home",
            and: UIImage(systemName: "house"),
            viewController: homeVc
        )

        let favoritesVc = UIViewController()
        favoritesVc.view.backgroundColor = .white
        let nav2 = createNav(
            with: "Favorites",
            and: UIImage(systemName: "star"),
            viewController: favoritesVc
        )

        let settingsVc = UIViewController()
        settingsVc.view.backgroundColor = .white
        let nav3 = createNav(
            with: "Settings",
            and: UIImage(systemName: "gear"),
            viewController: settingsVc
        )

        viewControllers = [nav1, nav2, nav3]
    }
    
    func createNav(
        with title: String, // Bu, Swift’te kullanılan external parameter name örneğidir.with burada fonksiyonu çağıran kişi için okunabilirliği artırır.
        and image: UIImage?,
        viewController: UIViewController
    ) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        viewController.title = title
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.largeTitleDisplayMode = .always
        navController.tabBarItem = UITabBarItem(
            title: title,
            image: image,
            selectedImage: image
        )
        return navController
    }
}
