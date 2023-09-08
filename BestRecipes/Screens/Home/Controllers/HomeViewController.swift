//
//  ViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class HomeViewController: UIViewController {

  // MARK: - Properties
  private let searchBar = SearchBar()
  private let trendingCollectionView = TrendingCollectionView()
  private let categoryName = CategoriesNames()
  private let categoryCollectionView = CategoriesCollectionView()
  private let cuisineCollectionView = СuisineCollectionView()
  private let recentCollectionView = RecentCollectionView()
  private var apiKeyIndex = 0

  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  private let mainLabel = UILabel.makeLabelForCells(text: "Get amazing recipes for cooking", font: .poppinsSemiBold(size: 24), textColor: .neutral100)
  private let trendingLabel = UILabel.makeLabelForCells(text: "Trending now 🔥", font: .poppinsSemiBold(size: 20), textColor: .neutral100)
  private let categoryLabel = UILabel.makeLabelForCells(text: "Popular category", font: .poppinsSemiBold(size: 20), textColor: .neutral100)
  private let recentRecipeLabel = UILabel.makeLabelForCells(text: "Recent recipe", font: .poppinsSemiBold(size: 20), textColor: .neutral100)
  private let cuisineLabel = UILabel.makeLabelForCells(text: "Popular cuisine", font: .poppinsSemiBold(size: 20), textColor: .neutral100)
  
  let seeAllButtonTrend = SeeAllButton()
  let seeAllButtonCategory = SeeAllButton()
  let seeAllButtonCuisine = SeeAllButton()

  // MARK: - Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    hideKeyBoard()
    configureSeeAllButtons()
    setupScrollView()
    setupSearchBar()
    setupCollectionView()
    setupConstraints()
    loadTrendingRecipes()
    fetchFirstSearch()
    setupDelegates()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchRecentRecipe()
    navigationController?.setNavigationBarHidden(false, animated: false)
    tabBarController?.tabBar.isHidden = false
    trendingCollectionView.collectionView.reloadData()
  }

  // MARK: - Private Methods
  private func setupDelegates() {
    categoryName.delegateCollectionDidSelect = self
    cuisineCollectionView.delegateCollectionDidSelect = self
    categoryCollectionView.delegate = self
    trendingCollectionView.delegate = self
    recentCollectionView.delegate = self
  }
  
  private func hideKeyBoard() {
    let backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
    backgroundTapGesture.cancelsTouchesInView = false
    scrollView.addGestureRecognizer(backgroundTapGesture)
  }
  
  @objc private func didTapBackground() {
    view.endEditing(true)
  }
  
  private func setupScrollView() {
    view.addSubview(scrollView)
    scrollView.contentSize = CGSize(width: .zero, height: 1400)
    scrollView.backgroundColor = .white
  }
  
  private func setupSearchBar() {
    searchBar.searchBar.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(searchBar.view)
    scrollView.addSubview(mainLabel)
  }
  
  private func setupCollectionView() {
    trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
    categoryName.translatesAutoresizingMaskIntoConstraints = false
    categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
    cuisineCollectionView.translatesAutoresizingMaskIntoConstraints = false
    recentCollectionView.translatesAutoresizingMaskIntoConstraints = false

    scrollView.addSubview(trendingCollectionView)
    scrollView.addSubview(trendingLabel)
    scrollView.addSubview(seeAllButtonTrend)
    scrollView.addSubview(categoryLabel)
    scrollView.addSubview(seeAllButtonCategory)
    scrollView.addSubview(categoryName)
    scrollView.addSubview(categoryCollectionView)
    scrollView.addSubview(cuisineLabel)
    scrollView.addSubview(seeAllButtonCuisine)
    scrollView.addSubview(cuisineCollectionView)
    scrollView.addSubview(recentRecipeLabel)
    scrollView.addSubview(recentCollectionView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      searchBar.view.topAnchor.constraint(equalTo:  mainLabel.bottomAnchor, constant: 8),
      searchBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      searchBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      
      mainLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
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
      
      seeAllButtonCategory.topAnchor.constraint(equalTo: trendingCollectionView.bottomAnchor, constant: 8),
      seeAllButtonCategory.trailingAnchor.constraint(equalTo: seeAllButtonTrend.trailingAnchor),

      categoryName.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
      categoryName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      categoryName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      categoryName.heightAnchor.constraint(equalToConstant: 40),
      
      categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      categoryCollectionView.topAnchor.constraint(equalTo: categoryName.bottomAnchor, constant: 8),
      categoryCollectionView.heightAnchor.constraint(equalToConstant: 210),
      
      cuisineLabel.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 8),
      cuisineLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
      cuisineLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),
      
      seeAllButtonCuisine.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 8),
      seeAllButtonCuisine.trailingAnchor.constraint(equalTo: seeAllButtonCategory.trailingAnchor),

      cuisineCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      cuisineCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      cuisineCollectionView.topAnchor.constraint(equalTo: cuisineLabel.bottomAnchor, constant: 10),
      cuisineCollectionView.heightAnchor.constraint(equalToConstant: 200),

      recentRecipeLabel.topAnchor.constraint(equalTo: cuisineCollectionView.bottomAnchor, constant: 8),
      recentRecipeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
      recentRecipeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),

      recentCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      recentCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      recentCollectionView.topAnchor.constraint(equalTo: recentRecipeLabel.bottomAnchor, constant: 10),
      recentCollectionView.heightAnchor.constraint(equalToConstant: 200),
      recentCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
    ])
  }
  
  // MARK: - Methods for loading data from API
  private func checkKey() {
    apiKeyIndex += 1
    if apiKeyIndex >= apiKey.count {
      apiKeyIndex = 0
    }
    apiKeySelect = apiKey[apiKeyIndex]
  }

  private func loadTrendingRecipes() {
    Task {
      do {
        let response = try await RecipeAPI.fetchTrends()
        self.trendingCollectionView.recipes = response.results
        var recipesId: String = ""
        for number in 0..<self.trendingCollectionView.recipes.count {
          recipesId += String(self.trendingCollectionView.recipes[number].id) + ","
        }
        let secondResponce = try await RecipeAPI.fetchFullInfoFromIdString(with: recipesId)
        self.trendingCollectionView.recipeFullInfo = secondResponce
        self.seeAllButtonTrend.recipes = secondResponce
      } catch {
        checkKey()
        loadTrendingRecipes()
      }
    }
  }
  
  private func fetchFirstSearch() {
    Task {
      do {
        let data = try await RecipeAPI.fetchSearch(with: "Main Course")
        self.categoryCollectionView.recipes = data.results
        var recipesId: String = ""
        for number in 0...( self.categoryCollectionView.recipes.count - 1) {
          recipesId += String( self.categoryCollectionView.recipes[number].id) + ","
          let secondResponce =  try await RecipeAPI.fetchFullInfoFromIdString(with: recipesId)
          self.categoryCollectionView.recipeFullInfo = secondResponce
          self.seeAllButtonCategory.recipes = secondResponce
        }
      } catch {
        await MainActor.run {
          checkKey()
          fetchFirstSearch()
        }
      }
    }
  }

  private func fetchRecentRecipe() {
    Task {
      do {
        let arrayOfId =  GetFromCoreData.getRecentIdFromCoreData()
        let resultString = arrayOfId.map(String.init).joined(separator: ",")

        let data = try await RecipeAPI.fetchFullInfoFromIdString(with: resultString)
        self.recentCollectionView.recipesFull = data
      } catch {
        await MainActor.run {
          checkKey()
          fetchRecentRecipe()
        }
      }
    }
  }
}

//MARK: - Extensions for collections
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
          self.seeAllButtonCategory.recipes = secondResponce
          self.seeAllButtonCategory.name = categoryName
        }
      } catch {
        await MainActor.run {
          checkKey()
          fetchSearch(categoryName: categoryName)
        }
      }
    }
  }
}

extension HomeViewController: CollectionCuisineDidSelectProtocol {
  func fetchCuisine(cuisine: String) {
    let resultsViewController = ResultsViewController(cuisine: cuisine)
    resultsViewController.modalPresentationStyle = .currentContext
    self.present(resultsViewController, animated: true, completion: nil)
  }
}

extension HomeViewController: CategoriesCollectionViewDelegate, TrendingCollectionViewDelegate {
  func didSelectRecipe(_ recipe: Recipe) {
    SaveToCoreData.saveRecentArrayToCoreData(recipe.id)
    let recipeDetailsVC = RecipeDetailView()
    recipeDetailsVC.recipe = recipe
    recipeDetailsVC.modalPresentationStyle = .fullScreen
    present(recipeDetailsVC, animated: true, completion: nil)
  }
}

extension HomeViewController: RecentCollectionViewDelegate {
  func didSelectRecipeRe(_ recipe: RecipeInfoForCell) {
    let recipeDetailsVC = RecipeDetailView()
    SaveToCoreData.saveRecentArrayToCoreData(recipe.id)
    recipeDetailsVC.recipeFromSeeAll = recipe
    recipeDetailsVC.modalPresentationStyle = .fullScreen
    present(recipeDetailsVC, animated: true, completion: nil)
  }
}
