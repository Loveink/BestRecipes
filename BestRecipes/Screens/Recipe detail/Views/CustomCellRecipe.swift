//
//  CustomCellRecipe2.swift
//  BestRecipes
//
//  Created by Тимур on 29.08.2023.
//

import UIKit

class CustomCellRecipe: UITableViewCell {
    
    var dishImageView = UIImageView()
    var titleLbl = UILabel()
    var descriptionLbl = UILabel()
    var stackView = UIStackView()
    var viewCardView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "CustomCellRecipe")
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Please use this class from code.")
    }
    
    private func setupUI() {
        

        backgroundColor = UIColor.white
        selectionStyle = .none
        
        contentView.addSubview(viewCardView)
        
        contentView.contentMode = .center
        contentView.isMultipleTouchEnabled = true
        
        viewCardView.addSubview(dishImageView)
        viewCardView.addSubview(stackView)
        
        viewCardView.backgroundColor = UIColor(white: 0.66666666666666663, alpha: 1)
        viewCardView.translatesAutoresizingMaskIntoConstraints = false
        
        viewCardView.setValue(10, forKeyPath: "cornerRadius")
        
        stackView.addArrangedSubview(titleLbl)
        stackView.addArrangedSubview(descriptionLbl)
        
        stackView.backgroundColor = UIColor(white: 0, alpha: 0)
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLbl.contentMode = .left
        descriptionLbl.font = UIFont.systemFont(ofSize: 14)
        descriptionLbl.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        descriptionLbl.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        descriptionLbl.text = "Label"
        descriptionLbl.textAlignment = .right
        descriptionLbl.textColor = UIColor.systemGray
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        
        titleLbl.contentMode = .left
        titleLbl.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        titleLbl.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        titleLbl.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        titleLbl.text = "Label"
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        dishImageView.clipsToBounds = true
        dishImageView.contentMode = .scaleAspectFill
        dishImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        dishImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        dishImageView.translatesAutoresizingMaskIntoConstraints = false
        dishImageView.accessibilityTraits = [.image, .notEnabled]
        
        dishImageView.setValue(5, forKeyPath: "cornerRadius")
    }
    
    private func setupLayout() {
        
        // Ограничения для viewCardView
        viewCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        viewCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        viewCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        viewCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        // Ограничения для stackView и dishImageView
        dishImageView.leadingAnchor.constraint(equalTo: viewCardView.leadingAnchor, constant: 16).isActive = true
        dishImageView.topAnchor.constraint(equalTo: viewCardView.topAnchor, constant: 16).isActive = true
        dishImageView.bottomAnchor.constraint(equalTo: viewCardView.bottomAnchor, constant: -16).isActive = true
        dishImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        dishImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 16).isActive = true
        stackView.topAnchor.constraint(equalTo: viewCardView.topAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: viewCardView.trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: viewCardView.bottomAnchor, constant: -16).isActive = true
    }
}


