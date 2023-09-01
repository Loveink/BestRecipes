//
//  ViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class HomeViewController: UIViewController {
  private let searchBar = SearchBar()
  private let trendingCollectionView = TrendingCollectionView()
  private let categoryName = CategoriesNames()
  private let categoryCollectionView = CategoriesCollectionView()

  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()

  var mainLabel = UILabel.makeLabelForCells(text: "Get amazing recipes for cooking", font: .poppinsSemiBold(size: 24), textColor: .neutral100)
  var trendingLabel = UILabel.makeLabelForCells(text: "Trending now 🔥", font: .poppinsSemiBold(size: 20), textColor: .neutral100)
  var categoryLabel = UILabel.makeLabelForCells(text: "Popular category", font: .poppinsSemiBold(size: 20), textColor: .neutral100)
  var recentRecipeLabel = UILabel.makeLabelForCells(text: "Recent recipe", font: .poppinsSemiBold(size: 20), textColor: .neutral100)
  var cuisineLabel = UILabel.makeLabelForCells(text: "Popular cuisine", font: .poppinsSemiBold(size: 20), textColor: .neutral100)

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
    fetchFirstSearch()

    categoryName.delegateCollectionDidSelect = self
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
    trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
    categoryName.translatesAutoresizingMaskIntoConstraints = false
    categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false

    scrollView.addSubview(trendingCollectionView)
    scrollView.addSubview(trendingLabel)
    scrollView.addSubview(seeAllButtonTrend)
    scrollView.addSubview(categoryLabel)
    scrollView.addSubview(seeAllButtonRecipe)
    scrollView.addSubview(categoryName)
    scrollView.addSubview(categoryCollectionView)
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

      trendingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      trendingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      trendingCollectionView.topAnchor.constraint(equalTo: trendingLabel.bottomAnchor, constant: 8),
      trendingCollectionView.heightAnchor.constraint(equalToConstant: 250),

      categoryLabel.topAnchor.constraint(equalTo: trendingCollectionView.bottomAnchor, constant: 8),
      categoryLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
      categoryLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),

      seeAllButtonRecipe.topAnchor.constraint(equalTo: trendingCollectionView.bottomAnchor, constant: 8),
      seeAllButtonRecipe.trailingAnchor.constraint(equalTo: seeAllButtonTrend.trailingAnchor),
      
      categoryName.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
      categoryName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      categoryName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      categoryName.heightAnchor.constraint(equalToConstant: 40),

      categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      categoryCollectionView.topAnchor.constraint(equalTo: categoryName.bottomAnchor, constant: 8),
      categoryCollectionView.heightAnchor.constraint(equalToConstant: 250),
    ])
  }
  
  private func loadTrendingRecipes() {
    Task {
      do {
        let response = try await RecipeAPI.fetchTrends()
        self.trendingCollectionView.recipes = response.results
        var recipesId: String = ""
        for number in 0...( self.trendingCollectionView.recipes.count - 1) {
          recipesId += String( self.trendingCollectionView.recipes[number].id) + ","
          let secondResponce =  try await RecipeAPI.fetchFullInfoFromIdString(with: recipesId)
          self.trendingCollectionView.recipeFullInfo = secondResponce
        }
      } catch {
        await MainActor.run(body: {
          print(error, error.localizedDescription)
        })
      }
    }
  }

  func fetchFirstSearch() {
      Task {
          do {
              let data = try await RecipeAPI.fetchSearch(with: "Main Course")
            self.categoryCollectionView.recipes = data.results
            var recipesId: String = ""
            for number in 0...( self.categoryCollectionView.recipes.count - 1) {
              recipesId += String( self.categoryCollectionView.recipes[number].id) + ","
              let secondResponce =  try await RecipeAPI.fetchFullInfoFromIdString(with: recipesId)
              self.categoryCollectionView.recipeFullInfo = secondResponce
            }
          } catch {
              await MainActor.run {
                  print(error)
              }
          }
      }
  }
}

extension HomeViewController: CollectionDidSelectProtocol {
    func fetchSearch(categoryName: String) {
        Task {
            do {
                let data = try await RecipeAPI.fetchSearch(with: categoryName)
              self.categoryCollectionView.recipes = data.results
              var recipesId: String = ""
              for number in 0...( self.categoryCollectionView.recipes.count - 1) {
                recipesId += String( self.categoryCollectionView.recipes[number].id) + ","
                let secondResponce =  try await RecipeAPI.fetchFullInfoFromIdString(with: recipesId)
                self.categoryCollectionView.recipeFullInfo = secondResponce
              }
            } catch {
                await MainActor.run {
                    print(error)
                }
            }
        }
    }
}
