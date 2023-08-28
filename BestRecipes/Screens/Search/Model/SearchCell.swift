//
//  SearchCell.swift
//  Test3
//
//  Created by Vanopr on 28.08.2023.
//
import UIKit
class SearchTableViewCell: UITableViewCell {
    let recipeImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(recipeImageView)
        addSubview(titleLabel)
        
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            recipeImageView.widthAnchor.constraint(equalToConstant: 120), // Ширина изображения
            recipeImageView.heightAnchor.constraint(equalToConstant: 70), // Высота изображения
            titleLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 70),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant:  5)
        ])
    }
}
