//
//  SeeAllButton.swift
//  BestRecipes
//
//  Created by Александра Савчук on 27.08.2023.
//

import UIKit

class SeeAllButton: UIButton {

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
