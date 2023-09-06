//
//  RecentCollectionView.swift
//  BestRecipes
//
//  Created by Александра Савчук on 01.09.2023.
//

import UIKit

protocol RecentCollectionViewDelegate: AnyObject {
  func didSelectRecipe(_ recipe: Recipe)
}

class RecentCollectionView: UIView {

  var collectionView: UICollectionView!
  weak var delegate: RecentCollectionViewDelegate?
  var navController: UIViewController!
  var recipes: [RecipeInfoForCell] = [] {
      didSet {
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    }

    override func layoutSubviews() {
            super.layoutSubviews()
        collectionView.reloadData()
        }
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    configureCollection()
    addSubview(collectionView)
    setupConstraints()
  }


  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

    
    
  func configureCollection() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(RecentCell.self, forCellWithReuseIdentifier: RecentCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

//MARK: - Extensions
extension RecentCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return recipes.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCell.identifier, for: indexPath) as? RecentCell else {
      return UICollectionViewCell()
    }
      let recipe = recipes[indexPath.row]
      cell.configureCell(recipe)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 150, height: 210)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let recipeDetailsVC = RecipeDetailView()
      recipeDetailsVC.recipeFromSeeAll = recipes[indexPath.row]
      recipeDetailsVC.modalPresentationStyle = .currentContext
      self.navController.present(recipeDetailsVC, animated: true)
  }
}
