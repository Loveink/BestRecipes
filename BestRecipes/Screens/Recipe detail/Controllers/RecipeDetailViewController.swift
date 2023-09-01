//
//  RecipeDetailViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import Foundation
import UIKit


class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe?
    let navigationBar = CustomNavigationBar()

    override func viewDidLoad()  {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setConstrains()
    }
    
    private func setupNavBar() {
        navigationBar.titleOfViewLabel.text = ""
        navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(navigationBar)
        view.addSubview(navigationBar.view)
        navigationBar.didMove(toParent: self)
    }
    
    private func setConstrains() {
        NSLayoutConstraint.activate([
            navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.view.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
}
