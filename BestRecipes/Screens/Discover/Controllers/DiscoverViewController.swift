//
//  DiscoverViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    let bookmarksManager = BookmarksManager.shared
    var recipes: [RecipeInfoForCell] = []
    
    let tableView = UITableView()
    var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "Saved recipes"
        self.view.backgroundColor = .white
        configureCollection()
        setConstraints()
        reloadFavouriteRecipes()
    }
    
    
    func reloadFavouriteRecipes() {
        recipes = bookmarksManager.getBookmarks()
        collectionView.reloadData()
    }
    
    
    
    private func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5),
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    
}





extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCell.identifier, for: indexPath) as? TrendingCell else {
            return UICollectionViewCell()
        }
        cell.liked = true
        cell.favouriteButton.setImage(UIImage(named: "bookmarkSelect"), for: .normal)
        cell.configureCell(recipes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 10, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}
