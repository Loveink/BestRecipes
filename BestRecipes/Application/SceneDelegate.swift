//
//  SceneDelegate.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      guard let windowScene = (scene as? UIWindowScene) else { return }
      let window = UIWindow(windowScene: windowScene)
      self.window = window

      if isOnboardingCompleted() {
          let tabBarController = MainTabBarController()
        window.rootViewController = tabBarController
      } else {
          window.rootViewController = OnboardingViewController()
      }

      window.makeKeyAndVisible()
  }

  private func isOnboardingCompleted() -> Bool {
    return UserDefaults.standard.bool(forKey: "isOnboardingCompleted")
  }
}
