//
//  ViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class HomeViewController: UIViewController {
  private let searchBar = SearchBar()
  private let collectionView = TrendingCollectionView()

  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()

  var mainLabel = UILabel.makeLabelForCells(text: "Get amazing recipes for cooking", font: .poppinsSemiBold(size: 24), textColor: .black)
  var trendingLabel = UILabel.makeLabelForCells(text: "Trending now 🔥", font: .poppinsSemiBold(size: 20), textColor: .black)

  var seeAllButtonTrend = SeeAllButton()
  var seeAllButtonRecipe = SeeAllButton()
  var seeAllButtonCreators = SeeAllButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setupScrollView()
    setupSearchBar()
    setupNameView()
    setupCollectionView()
    setupConstraints()
    loadTrendingRecipes()
  }

  func setupScrollView() {
    view.addSubview(scrollView)
    scrollView.contentSize = CGSize(width: .zero, height: 1400)
    scrollView.backgroundColor = .white
  }
  func setupSearchBar() {
    searchBar.searchBar.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(searchBar.view)
  }

  func setupNameView() {
    scrollView.addSubview(mainLabel)
  }

  func setupCollectionView() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(collectionView)
    scrollView.addSubview(trendingLabel)
    scrollView.addSubview(seeAllButtonTrend)
  }

  
  private func setupConstraints() {



    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      searchBar.view.topAnchor.constraint(equalTo:  mainLabel.bottomAnchor, constant: 8),
      searchBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      searchBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

      mainLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -20),
      mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      mainLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),

      trendingLabel.topAnchor.constraint(equalTo: searchBar.view.bottomAnchor, constant: 8),
      trendingLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
      trendingLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),

      seeAllButtonTrend.topAnchor.constraint(equalTo: searchBar.view.bottomAnchor, constant: 8),
      seeAllButtonTrend.trailingAnchor.constraint(equalTo: searchBar.searchBar.trailingAnchor, constant: 8),

      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      collectionView.topAnchor.constraint(equalTo: trendingLabel.bottomAnchor, constant: 8),
      collectionView.heightAnchor.constraint(equalToConstant: 250)
    ])
  }
  
  private func loadTrendingRecipes() {
    Task {
      do {
        let response = try await RecipeAPI.fetchTrends()
        self.collectionView.recipes = response.results
        var recipesId: String = ""
        for number in 0...( self.collectionView.recipes.count - 1) {
          recipesId += String( self.collectionView.recipes[number].id) + ","
          let secondResponce =  try await RecipeAPI.fetchFullInfoFromIdString(with: recipesId)
          self.collectionView.recipeFullInfo = secondResponce
        }

      } catch {
        await MainActor.run(body: {
          print(error, error.localizedDescription)
        })
      }
    }
  }
}
