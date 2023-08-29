//
//  CustomCellRecipe.swift
//  BestRecipes
//
//  Created by Тимур on 29.08.2023.
//

import UIKit

class CustomCellRecipe: UITableViewCell {
    
    let roundImageView = UIImageView()
    let leftTextLabel = UILabel()
    let rightTextLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Настройка элементов внутри ячейки
        roundImageView.translatesAutoresizingMaskIntoConstraints = false
        leftTextLabel.translatesAutoresizingMaskIntoConstraints = false
        rightTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(roundImageView)
        contentView.addSubview(leftTextLabel)
        contentView.addSubview(rightTextLabel)
        
        // Настройка constraints
        NSLayoutConstraint.activate([
            roundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            roundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            roundImageView.widthAnchor.constraint(equalTo: roundImageView.heightAnchor), // Круглая картинка
            
            leftTextLabel.leadingAnchor.constraint(equalTo: roundImageView.trailingAnchor, constant: 8),
            leftTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            rightTextLabel.leadingAnchor.constraint(equalTo: leftTextLabel.trailingAnchor, constant: 8),
            rightTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            rightTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rightTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
