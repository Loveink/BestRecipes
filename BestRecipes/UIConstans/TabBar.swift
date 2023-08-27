//
//  TabBar.swift
//  BestRecipes
//
//  Created by Александра Савчук on 27.08.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    setupTabBar()
    setupItems()
  }

  private func setupTabBar() {
    tabBar.backgroundColor = .white0
//    tabBar.backgroundImage = UIImage(named: "Bg")
  }


  private func setupItems() {
    
    let customButtonController = UIViewController()
    customButtonController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "add")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "add")?.withRenderingMode(.alwaysOriginal))
    customButtonController.tabBarItem.imageInsets = UIEdgeInsets(top: -20, left: 0, bottom: 20, right: 0)


    let homepage = HomeViewController()
    homepage.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "main")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "mainSelect")?.withRenderingMode(.alwaysOriginal))

    let discover = DiscoverViewController()
    discover.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "bookmark")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bookmarkSelect")?.withRenderingMode(.alwaysOriginal))

    let notification = FavoritesViewController()
    notification.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "notification")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "notificationSelect")?.withRenderingMode(.alwaysOriginal))

    let profile = ProfilePageViewController()
    profile.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "profileSelect")?.withRenderingMode(.alwaysOriginal))

    setViewControllers([homepage, discover, customButtonController, notification, profile], animated: true)
  }
}
