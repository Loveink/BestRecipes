//
//  CustomCellRecipe2.swift
//  BestRecipes
//
//  Created by Тимур on 29.08.2023.
//

import UIKit

class DishListTableViewCell: UITableViewCell {

   private lazy var dishImageView = UIImageView()
   private lazy var titleLbl = UILabel()
   private lazy var descriptionLbl = UILabel()
   private lazy var stackView = UIStackView()
   private lazy var viewCardView = UIView()

   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: "DishListTableViewCell")
      setupUI()
      setupLayout()
   }

   required init?(coder: NSCoder) {
      fatalError("Please use this class from code.")
   }

   private func setupUI() {

      autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
      backgroundColor = UIColor.white
      frame = CGRect(x: 0, y: 0, width: 337, height: 102)
      selectionStyle = .none

      contentView.addSubview(viewCardView)

      contentView.backgroundColor = UIColor.white
      contentView.contentMode = .center
      contentView.isMultipleTouchEnabled = true

      viewCardView.addSubview(dishImageView)
      viewCardView.addSubview(stackView)

      viewCardView.backgroundColor = UIColor.white
      viewCardView.translatesAutoresizingMaskIntoConstraints = false

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

      dishImageView.setValue(10, forKeyPath: "cornerRadius")
   }

   private func setupLayout() {

      viewCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
      trailingAnchor.constraint(equalTo: viewCardView.trailingAnchor, constant: 16).isActive = true
      viewCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
      bottomAnchor.constraint(equalTo: viewCardView.bottomAnchor, constant: 10).isActive = true

      viewCardView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 16).isActive = true
      dishImageView.topAnchor.constraint(equalTo: viewCardView.topAnchor, constant: 16).isActive = true
      viewCardView.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 16).isActive = true
      stackView.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: 16).isActive = true
      dishImageView.leadingAnchor.constraint(equalTo: viewCardView.leadingAnchor, constant: 16).isActive = true
      stackView.topAnchor.constraint(equalTo: dishImageView.topAnchor).isActive = true
      stackView.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor).isActive = true

      dishImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
      dishImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
   }
}

