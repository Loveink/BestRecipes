//
//  SeeAllButton.swift
//  BestRecipes
//
//  Created by Александра Савчук on 27.08.2023.
//

import UIKit

class SeeAllButton: UIButton {
    
    var name: String!
    
    var recipes = [RecipeInfoForCell]() {
        didSet {
//            print("SeeAllButton recipes didSet")
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        self.backgroundColor = .white
        self.tintColor = .black
        self.setTitleColor(.primary50, for: .normal)
        self.setTitle("See All ", for: .normal)
        self.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        self.titleLabel?.font = .poppinsSemiBold(size: 14)
        self.semanticContentAttribute = .forceRightToLeft
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    
    
}



extension HomeViewController {
    @objc func seeAllButtonWasTapped(sender: SeeAllButton) {
        let viewController = SeeAllViewController(title: sender.name, recipes: sender.recipes)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func configureSeeAllButtons() {
        seeAllButtonTrend.addTarget(self, action: #selector(seeAllButtonWasTapped), for: .touchUpInside)
        seeAllButtonTrend.name = "Trending now"
        seeAllButtonCategory.addTarget(self, action: #selector(seeAllButtonWasTapped), for: .touchUpInside)
        seeAllButtonCategory.name = "Main Course"
        seeAllButtonRecent.addTarget(self, action: #selector(seeAllButtonWasTapped), for: .touchUpInside)
        seeAllButtonRecent.name = "Creators"
    }
    
}
