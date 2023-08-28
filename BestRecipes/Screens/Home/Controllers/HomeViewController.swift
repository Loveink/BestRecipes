//
//  ViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class HomeViewController: UIViewController {
  private   let searchBar = SearchBar()
  private let collectionView = TrendingCollectionView()
    
   private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    
    var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 35)
        label.text = """
                     Get amazing recipes
                     for cooking
                     """
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()

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
    }
    
  
  private func setupConstraints() {
      
     
      
    NSLayoutConstraint.activate([
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        
        searchBar.view.topAnchor.constraint(equalTo:  scrollView.topAnchor),
        searchBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        searchBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        
        mainLabel.topAnchor.constraint(equalTo: searchBar.searchBar.bottomAnchor, constant: 20),
        mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        mainLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
        
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        collectionView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 50),
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
