//
//  ViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class HomeViewController: UIViewController {
  
  private let collectionView = TrendingCollectionView()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    setupConstraints()
    loadTrendingRecipes()
  }
  
  private func setupConstraints() {
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
      collectionView.heightAnchor.constraint(equalToConstant: 250) 
    ])
  }
  
  private func loadTrendingRecipes() {
    Task {
      do {
        let response = try await RecipeAPI.fetchTrends()
        self.collectionView.recipes = response.results
      } catch {
        await MainActor.run(body: {
          print(error, error.localizedDescription)
        })
      }
    }
  }
}
