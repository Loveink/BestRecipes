//
//  DiscoverViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    var collectionView = DiscoverCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "Saved recipes"
        self.view.backgroundColor = .white
        setupCollectionView()
        setConstraints()
        reloadFavouriteRecipes()
    }
    
    
    func reloadFavouriteRecipes() {
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
}
